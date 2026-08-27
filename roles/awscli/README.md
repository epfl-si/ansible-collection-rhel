Role AWS CLI
=========

Install and configure AWS CLI v2. Use this role with `become: true` because it needs permissions to write into `awscli_install_dir` and /tmp as root.

This role handle multiple profiles configured on the same computer at the same time. To switch between profiles, use `aws <command> --profile <name>`

Initialy, this role was created to use `aws s3` command only. No other commands will be supported unless someone add them via a pull request.

It is your responsibility to ensure that one of the profile is marked as 'default'.


Requirements
------------

* Unzip

Role Variables
--------------

The role parameters are in meta/argument_specs.yml or use the command `ansible-doc --type role awscli` to read them.

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

Or if you prefer to use a loop, do use `tasks_from` to avoid installing the
binary for each profile.

```yaml
---
- hosts: all
  tasks:

    - name: Import role awscli install
      ansible.builtin.import_role:
        name: epfl_si.rhel.awscli
        tasks_from: install.yml
      when:
        - awscli_users_profiles is defined
        - awscli_users_profiles | length > 0
      tags: awscli

    - name: Include role awscli configure
      ansible.builtin.include_role:
        name: epfl_si.rhel.awscli
        tasks_from: configure.yml
        apply:
          tags: awscli
      vars:
        awscli_user: "{{ awscli_item.awscli_user }}"
        awscli_default_s3_max_concurrent_requests: '5'
        awscli_profiles: "{{ awscli_item.awscli_profiles }}"
      loop: "{{ awscli_users_profiles }}"
      loop_control:
        loop_var: awscli_item
      when:
        - awscli_users_profiles is defined
        - awscli_users_profiles | length > 0
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
