Role Name
=========

Install and configure s3cmd

This role handle multiple buckets configure on the same computer at the same time. The defaults one can be use with `s3cmd` command. The other one must be specified `s3cmd --config=~/.s3cfg-my-secondary-bucket`

Requirements
------------

None

Role Variables
--------------


* `s3cmd_buckets`: Dictionary of buckets with their configurations
* `s3cmd_users_access:` List of buckets to intall per user with either Read/Write or Read only permissions. A single bucket can be set as default. The default bucket will have an additional configuration file copied in the standard location in `~/.s3cfg`.

Per example:

```yaml
s3cmd_buckets:
  bucket1:
    s3_access_key_rw: key1
    s3_secret_key_rw: secret1
    s3_access_key_ro: key2
    s3_secret_key_ro: secret2
    s3_host_bucket: '%(bucket)s.s3.amazonaws.com'
    s3_human_readable_sizes: true
    s3_host_base: s3.example.com
    s3_website_endpoint: s3.example.com
  bucket2:
    s3_access_key_rw: key3
    s3_secret_key_rw: secret3
    s3_access_key_ro: key4
    s3_secret_key_ro: secret4
    s3_host_bucket: '%(bucket)s.s3.amazonaws.com'
    s3_human_readable_sizes: false
    s3_host_base: s3.example.com
    s3_website_endpoint: s3.example.com

s3cmd_users_access:
  - user: root
    bucket: bucket1
    grant: read_write
  - user: root
    bucket: bucket2
    grant: read_only
    default: true
```

Only the following [s3cmd options](https://s3tools.org/usage) are supported:

* access_key: string, required
* host_base: string, required
* host_bucket: string, required
* human_readable_sizes: Bool, optional, default False
* secret_key: string, required
* website_endpoint: string, optional, default empty


Dependencies
------------

None

Example Playbook
----------------


    - hosts: servers
      roles:
         - epfl_si.rhel.s3cmd
           vars:
             s3cmd_user: bob

Example Usage
-------------

```bash
s3cmd -c ~/.s3cfg-bucket-rw ls
```


License
-------

GPLv3

Author Information
------------------

laurent.indermuehle@epfl.ch
