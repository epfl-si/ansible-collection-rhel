Role AWS CLI
=========

Install and configure AWS CLI v2. Use this role with `become: true` in case your ansible user doesn't have the right to write into `awscli_install_dir`.

This role handle multiple profiles configured on the same computer at the same time. To switch between profiles, use `aws <command> --profile <name>`

Initialy, this role was created to use `aws s3` command only. No other commands will be supported unless someone add them via a pull request.

It is your responsibility to ensure that one of the profile is marked as 'default'.


Requirements
------------

* Unzip

Role Variables
--------------

### awscli_force_installation

* Choices / Defaults:
  * **no** <-
  * yes
* Required: no
* Comments: To force reinstallation or update to latestest revision. In case the last version was already installed, the installation will be redone also redone.


### awscli_state

* Choices / Defaults:
  * **present** <-
  * absent
* Required: no
* Comments: If state is set to absent, AWS cli will be uninstalled


### awscli_bin_dir

* Defaults: /usr/local/bin
* Required: no
* Comments: Location of the aws command. Be aware that new user doesn't have this location in their path on RHEL 8


### awscli_install_dir

* Defaults: /usr/local/aws-cli
* Required: no
* Comments: Location of the binary files


### awscli_user

* Required: **yes**
* Comments: The linux username where to install the configuration file


### awscli_profiles

* Required: **yes**
* Comments: Contains a list of profiles settings that holds the parameters bellow. The variables that have the `s3_` prefix are documented in the [AWS user guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)


#### name

* Required: **yes**
* Comments: A friendly name for the profile


#### region

* Defaults: 'eu-west-3'
* Required: **yes**
* Comments: If you have an s3 endpoint that doesn't use region it would be tempting to let this value at en empty string. Doing so will result by all sorts of errors (502 bad gateway notably). For this reason, the role provide a default value to 'eu-west-3 (Europe Paris). For a list of regions, look in [AWS service endpoints documentation](https://docs.aws.amazon.com/general/latest/gr/rande.html)


#### default

* Choices / Defaults:
  * **no** <-
  * yes
* Required: no
* Comments: One of the profiles should be marked as default. It will then be added to the `[default]` section of the configuration file. If no profiles are marked as default, the `aws` command will fail if used without the `--profile <name>` parameter


#### access_key

* Defaults: ''
* Required: **yes**
* Comments: The access_key used to authenticate


#### secret_key

* Defaults: ''
* Required: **yes**
* Comments: The secret_key used to authenticate


#### cli_auto_prompt

* Defaults: ''
* Required: no


#### cli_binary_format

* Defaults: 'base64'
* Required: no


#### cli_pager

* Defaults: ''
* Required: no
* Comments: To disable the pager, use the value "disabled". AWS CLI expect an empty string to disable the pager, but we already use that value in or Jinja template.


#### cli_timestamp_format

* Defaults: 'iso8601'
* Required: no


#### max_attempts

* Defaults: '2'
* Required: no


#### output

* Defaults: ''
* Required: no


#### s3_max_concurrent_requests

* Defaults: 10
* Required: no


#### s3_max_queue_size

* Defaults: 1000
* Required: no


#### s3_multipart_threshold

* Defaults: 8MB
* Required: no


#### s3_multipart_chunksize

* Defaults: 8MB
* Required: no


#### s3_max_bandwidth

* Defaults: unlimited
* Required: no


#### s3_use_accelerate_endpoint

* Defaults: false
* Required: no


#### s3_addressing_style

* Defaults: auto
* Required: no


#### s3_payload_signing_enabled

* Defaults: false
* Required: no


#### s3_use_dualstack_endpoint

* Defaults: false
* Required: no



### Tips to manage option from Ansible Inventory

It is recommended to store `access_key` and `secret_key` in a separate variable in the inventory if you manage more than one user.

Here is an example:

```yaml
---

# suggested store for keys and secrets
aws_credentials:
  profile1:
    access_key_rw: key1
    secret_key_rw: secret1
    access_key_ro: key2
    secret_key_ro: secret2
  profile2:
    access_key_rw: key3
    secret_key_rw: secret3
    access_key_ro: key4
    secret_key_ro: secret4

# You can change the default value for all profiles
s3_default_max_concurrent_requests: 2

# Suggested way to store configurations if you prefer to use a loop in
# your playbook (example bellow)
awscli_users_profiles:
  - awscli_user: root
    awscli_profiles:
      - name: profile1
        default: yes
        access_key: "{{ aws_credentials['profile1'].access_key_rw }}"
        secret_key: "{{ aws_credentials['profile1'].secret_key_rw }}"
      - name: profile2
        access_key: "{{ aws_credentials['profile2'].access_key_rw }}"
        secret_key: "{{ aws_credentials['profile2'].secret_key_rw }}"
        s3_multipart_threshold: 128MB
```

Dependencies
------------

None

Example Playbook
----------------

Configure the role using role parameters:

```yaml
---
- hosts: all
  roles:

    - role: epfl_si.rhel.awscli
      awscli_user: john
      awscli_default_s3_multipart_chunksize: 64MB
      awscli_profiles:
        - name: profile1
          default: yes
          access_key: "{{ aws_credentials['profile1'].access_key_rw }}"
          secret_key: "{{ aws_credentials['profile1'].secret_key_rw }}"
        - name: profile2
          access_key: "{{ aws_credentials['profile2'].access_key_rw }}"
          secret_key: "{{ aws_credentials['profile2'].secret_key_rw }}"
```

Or if you prefer to use a loop:

```yaml
---
- hosts: all
  tasks:

    - name: Include role awscli
      ansible.builtin.include_role:
        name: epfl_si.rhel.awscli
      vars:
        awscli_user: "{{ awscli_item.awscli_user }}"
        awscli_default_s3_max_concurrent_requests: '5'
        awscli_profiles: "{{ awscli_item.awscli_profiles }}"
      loop: "{{ awscli_users_profiles }}"
      loop_control:
        loop_var: awscli_item
      tags: awscli
```


### Update

```yaml
---
- hosts: all
  roles:

    - role: epfl_si.rhel.awscli
      awscli_force_installation: yes
      tags: awscli
```


### Uninstall

If you want to remove the AWS CLI binary and command you can use the following command. This will not remove the configuration files inside `~/.aws`.

```bash
ansible-playbook -i inv.yml play.yml --tags awscli -e "awscli_state=absent"
```

Example Usage
-------------

```bash
aws s3 \
--endpoint-url https://s3.example.com \
--profile profile2 \
ls svc0000-kasdkjf9889a7rfjhkjad
```

AWS CLI doesn't have a [configuration for the endpoint-url](https://github.com/aws/aws-cli/issues/1270) yet. Here is a shortcut:

```bash
alias aws='aws --endpoint-url https://s3.example.com'
```


License
-------

MIT


Author Information
------------------

laurent.indermuehle@epfl.ch
