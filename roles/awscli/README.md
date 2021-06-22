Role AWS CLI
=========

Install and configure AWS CLI v2

This role handle multiple profiles configured on the same computer at the same time. To switch between profiles, use `aws <command> --profile <name>`

Initialy, this role was created to use `aws s3` command only. No other commands will be supported unless someone add them via a pull request.

It is your responsibility to ensure that one of the profile is marked as 'default'.


Requirements
------------

None


Role Variables
--------------

Here is the [reference for s3_* options bellow](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)

* awscli_force_installation: (bool, default False) To force reinstallation or update to latestest revision
* awscli_state: (Either present or absent, default to present) If state is set to absent, AWS cli will be uninstalled
* awscli_user: (string, default '') The linux username where to install the configuration file. The role will use getent('passwd') to find the user home directory
* awscli_profiles: (list of hashes)
  * name: (string, default '') A friendly name for the profile.
  * region:
  * s3_read_only: false
  * s3_max_concurrent_requests: 10
  * s3_max_queue_size: 1000
  * s3_multipart_threshold: 8MB
  * s3_multipart_chunksize: 8MB
  * s3_max_bandwidth: 0
  * s3_use_accelerate_endpoint: false
  * s3_addressing_style: auto
  * s3_payload_signing_enabled false
  * s3_use_dualstack_endpoint: false


### Tips to manage option from Ansible Inventory

It is recommended to store `access_key` and `secret_key` in a separate variable in the inventory if you manage more than one user.

Here is an example:

```yaml
# group_vars/all/vars
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

# group_vars/my_group/vars
awscli_users_profile:
  - awscli_user: root
    awscli_profile:
      - name: profile1
        default: yes
        access_key: aws_credentials['profile1'].access_key_rw
        secret_key: aws_credentials['profile1'].secret_key_rw
      - name: profile2
        access_key: aws_credentials['profile2'].access_key_rw
        secret_key: aws_credentials['profile2'].secret_key_rw
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
      awscli_profile:
        - name: profile1
          access_key: aws_credentials['profile1'].access_key_rw
          secret_key: aws_credentials['profile1'].secret_key_rw
        - name: profile2
          access_key: aws_credentials['profile2'].access_key_rw
          secret_key: aws_credentials['profile2'].secret_key_rw
```

Or if you prefer to use a loop:

```yaml
---
- hosts: all
  tasks:

    - name: Include role awscli
      ansible.builtin.include_role:
        name: awscli
      vars:
        awscli_user: "{{ awscli_item.awscli_user }}"
        awscli_profiles: "{{ awscli_item.awscli_profiles }}"
      loop: "{{ awscli_users_profiles }}"
      loop_control:
        loop_var: awscli_item
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

GPLv3


Author Information
------------------

laurent.indermuehle@epfl.ch
