Role s3cmd
=========

Install and configure s3cmd

This role handle multiple buckets configure on the same computer at the same time. The defaults one can be use with `s3cmd` command. The other one must be specified `s3cmd --config=~/.s3cfg-my-secondary-bucket`

Requirements
------------

* pip3

On RHEL7, no package to intall pip exists for the builtin Python. For this reason, the easiest way to install pip is to activate the EPEL repo, then intall python3 + python3-pip3 packages.

Role Variables
--------------


* s3cmd_buckets
  * default: none **required**
  * type: Dictionary
  * Description: Store buckets configurations. It is recommended to store this in the inventory if you manage more than one user that has access to the same bucket.
* s3cmd_user
  * default: none *required**
  * type: string
  * description: The user for whom configure s3cmd. The user and user homedir must exists
* s3cmd_bucket
  * default: none **required**
  * type: string
  * description: The bucket name defined in `s3cmd_buckets`
* s3cmd_read_only
  * default: False
  * type: bool
  * description: Define if the bucket will be in read_write or read_only mode
* s3cmd_default
  * default: False
  * type: bool
  * description: Only one bucket can be the default. If sets multiple times, the last one executed wins.

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

Configure the role using role parameters:

```yaml
- hosts: servers
  roles:
    - epfl_si.rhel.s3cmd
      s3cmd_buckets:
        mybucket:
          s3_access_key_ro: key2
          s3_secret_key_ro: secret2
          s3_host_bucket: '%(bucket)s.s3.amazonaws.com'
          s3_human_readable_sizes: true
          s3_host_base: s3.example.com
          s3_website_endpoint: s3.example.com
      s3cmd_user: bob
      s3cmd_bucket: mybucket
      s3cmd_read_only: true
      s3cmd_default: true

Example Usage
-------------

```bash
s3cmd -c ~/.s3cfg-mybucket-ro ls
```


License
-------

GPLv3

Author Information
------------------

laurent.indermuehle@epfl.ch
