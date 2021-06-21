Role AWS CLI
=========

Install and configure AWS CLI v2

This role handle multiple buckets configured on the same computer at the same time. To switch between buckets, use `aws <command> --profile <friendly-name>`

Initialy, this role was created to use `aws s3` command only. No other commands will be supported unless someone add them via a pull request.

Supports two kind of credentials: read-write and read-only. By default, the role will use `access_key_rw` and `secret_key_rw`.


Requirements
------------

None


Role Variables
--------------

* awscli_force_installation: (bool, default False) To force reinstallation or update to latestest revision
* awscli_state: (Either present or absent, default to present) If state is set to absent, AWS cli will be uninstalled
* awscli_user: (string, default '') The linux username where to install the configuration file. The role will use getent('passwd') to find the user home directory
* awscli_buckets: (list of hashes)
  * friendly_name: (string, default '') A friendly name of your bucket. Used as a key in s3_buckets object explained bellow.
  * region:
  * access_key_rw:
  * secret_key_rw:
  * access_key_ro:
  * secret_key_ro:


### Tips to manage option from Ansible Inventory

It is recommended to store s3 options in the inventory if you manage more than one user that has access to the same bucket.

Here is an example:

```yaml
# group_vars/all/vars
s3_buckets:
  bucket1:
    access_key_rw: key1
    secret_key_rw: secret1
    access_key_ro: key2
    secret_key_ro: secret2
    host_base: s3.example.com
    region: EU
  bucket2:
    access_key_rw: key3
    secret_key_rw: secret3
    access_key_ro: key4
    secret_key_ro: secret4
    host_base: s3.example.com
    region: EU

# group_vars/my_group/vars
awscli_users_buckets:
  - awscli_user: root
    awscli_buckets:
      - friendly_name: bucket1
        default: yes
      - friendly_name: bucket2
        read_only: yes
```

Dependencies
------------

None

Example Playbook
----------------

Configure the role using role parameters:

```yaml
- hosts: all
  roles:

    - role: epfl_si.rhel.awscli
      awscli_user: john
      awscli_buckets:
        - friendly_name: bucket1
          default: yes
          region: EU
          read_only: no
        - friendly_name: bucket2
```

Or if you prefer to use a loop:

```yaml
- hosts: all
  tasks:

    - name: Include role awscli
      ansible.builtin.include_role:
        name: awscli
      vars:
        awscli_user: "{{ awscli_item.awscli_user }}"
        awscli_buckets: "{{ molecule_awscli_item.awscli_buckets }}"
      loop: "{{ awscli_users_buckets }}"
      loop_control:
        loop_var: awscli_item
```

Example Usage
-------------

```bash
aws s3 \
--endpoint-url https://s3.example.com \
--profile my-bucket \
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
