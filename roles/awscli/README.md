Role AWS CLI
=========

Install and configure AWS CLI v2

This role handle multiple buckets configure on the same computer at the same time. To switch between buckets, use `aws <command> --profile <friendly-name>`

Initialy, this role was created to use `aws s3` command only. No other commands will be supported unless someone add them via a pull request.

Requirements
------------

None


Role Variables
--------------

* awscli_force_installation: (bool, default False) To force reinstallation or update to latestest revision


### Tips to manage option from Ansible Inventory

It is recommended to store s3 options in the inventory if you manage more than one user that has access to the same bucket.

Here is an example:

```yaml
s3_buckets:
  bucket1:
    access_key_rw: key1
    secret_key_rw: secret1
    access_key_ro: key2
    secret_key_ro: secret2
    host_base: s3.example.com
  bucket2:
    access_key_rw: key3
    secret_key_rw: secret3
    access_key_ro: key4
    secret_key_ro: secret4
    host_base: s3.example.com
```

Dependencies
------------

None

Example Playbook
----------------

Configure the role using role parameters:

```yaml
- hosts: servers
  roles:

    - epfl_si.rhel.awscli

```

Example Usage
-------------

```bash
aws s3 --profile my-bucket ls
```


License
-------

GPLv3


Author Information
------------------

laurent.indermuehle@epfl.ch
