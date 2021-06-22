Role s3cmd
=========

Install and configure s3cmd

This role handle multiple buckets configured on the same computer at the same time. The defaults one can be use with `s3cmd` command. The other one must be specified `s3cmd --config=~/.s3cfg-my-secondary-bucket`.

If you experience a slow transfer rate or frequent errors when transferring data, we recommend replacing `s3cmd` with the `aws s3` command. This collection provides a [awscli](https://github.com/epfl-si/ansible-collection-rhel/tree/main/roles/awscli) role to manage it.


Requirements
------------

* pip3

On RHEL7, no package to intall pip exists for the builtin Python. For this reason, the easiest way to install pip is to activate the EPEL repo, then intall python3 + python3-pip3 packages. For an example, have a look at `molecule/default/prepare.yml`.


Role Variables
--------------


* s3cmd_bucket
  * default: none **required**
  * type: string
  * Description: The friendly name of the bucket to use. This will be used to name the .s3cfg file. E.G.: `.s3cfg-bucket1`
* s3cmd_user
  * default: none *required**
  * type: string
  * description: The user for whom configure s3cmd. The user and user homedir must exists
* s3cmd_access_key
  * default: False
  * type: bool
  * description: The key used to authenticate
* s3cmd_secret_key
  * default: False
  * type: bool
  * description: The secret key used to authenticate
* s3cmd_default
  * default: False
  * type: bool
  * description: Only one bucket can be the default. If sets multiple times, the last one executed wins.
* s3cmd_*
  * default: see `defaults/main.yml` for the list of parameters and their defaults values
  * Description: [S3cmd documentation](https://s3tools.org/kb/item14.htm)


### Tips to manage option from Ansible Inventory

It is recommended to store credentials in the inventory if you manage more than one user that has access to the same bucket.

Here is an example:

```yaml
---
aws_credentials:
  bucket1:
    access_key_rw: key1
    secret_key_rw: secret1
    access_key_ro: key2
    secret_key_ro: secret2
  bucket2:
    access_key_rw: key3
    secret_key_rw: secret3
    access_key_ro: key4
    secret_key_ro: secret4
```

Dependencies
------------

None

Example Playbook
----------------

Configure the role using role parameters:

```yaml
---
- hosts: servers
  roles:

    - role: epfl_si.rhel.s3cmd
      s3cmd_bucket: mybucket
      s3cmd_access_key: key2
      s3cmd_secret_key: secret2
      s3cmd_host_bucket: '%(bucket)s.s3.amazonaws.com'
      s3cmd_human_readable_sizes: true
      s3cmd_host_base: s3.example.com
      s3cmd_website_endpoint: s3.example.com
      s3cmd_user: bob
      s3cmd_default: true

    # Or with the aws_credentials dict in inventory:
    - role: epfl_si.rhel.s3cmd
      s3cmd_bucket: mybucket2
      s3cmd_access_key: "{{ aws_credentials['bucket2'].access_key_rw }}"
      s3cmd_secret_key: "{{ aws_credentials['bucket2'].secret_key_rw }}"
      s3cmd_user: bob
      s3cmd_default: true
```


Example Usage
-------------

```bash
s3cmd -c ~/.s3cfg-mybucket2 ls
```


License
-------

GPLv3

Author Information
------------------

laurent.indermuehle@epfl.ch
