Role s3cmd
=========

Install and configure s3cmd

This role handle multiple buckets configure on the same computer at the same time. The defaults one can be use with `s3cmd` command. The other one must be specified `s3cmd --config=~/.s3cfg-my-secondary-bucket`

If you experience a slow transfer rate or frequent errors when transferring data, we recommend replacing `s3cmd` with the `aws s3` command in the AWS CLI.


Requirements
------------

* pip3

On RHEL7, no package to intall pip exists for the builtin Python. For this reason, the easiest way to install pip is to activate the EPEL repo, then intall python3 + python3-pip3 packages.

Role Variables
--------------


* s3cmd_bucket
  * default: none **required**
  * type: string
  * Description: The friendly name of the bucket to use. This will be used to name the .s3cfg file. E.G.: `.s3cfg-bucket1-rw`
* s3cmd_options
  * default: see `templates/s3cfg.j2` for defaults values
  * type: Dictionary
  * Description: The keys correspond to the s3cmd options found in the configuration file: [default configuration](https://s3tools.org/kb/item14.htm)
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



### Tips to manage option from Ansible Inventory

It is recommended to store s3cmd options in the inventory if you manage more than one user that has access to the same bucket. The prefix "s3cmd_" is not used for s3cmd options to have shorter variables. So name your dictionary with a explicit name. Like `s3cmd_buckets` for instance.

Here is an example:

```yaml
s3cmd_buckets:
  bucket1:
    access_key_rw: key1
    secret_key_rw: secret1
    access_key_ro: key2
    secret_key_ro: secret2
    host_bucket: '%(bucket)s.s3.amazonaws.com'
    human_readable_sizes: true
    host_base: s3.example.com
    website_endpoint: s3.example.com
  bucket2:
    access_key_rw: key3
    secret_key_rw: secret3
    access_key_ro: key4
    secret_key_ro: secret4
    host_bucket: '%(bucket)s.s3.amazonaws.com'
    human_readable_sizes: false
    host_base: s3.example.com
    website_endpoint: s3.example.com
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

    - epfl_si.rhel.s3cmd
      s3cmd_bucket: mybucket
      s3cmd_options:
        access_key_ro: key2
        secret_key_ro: secret2
        host_bucket: '%(bucket)s.s3.amazonaws.com'
        human_readable_sizes: true
        host_base: s3.example.com
        website_endpoint: s3.example.com
      s3cmd_user: bob
      s3cmd_read_only: true
      s3cmd_default: true

      # Or with the s3cmd_buckets dict in inventory:
      - epfl_si.rhel.s3cmd
      s3cmd_bucket: mybucket2
      s3cmd_options: "{{ s3cmd_buckets['mybucket2'] }}"
      s3cmd_user: bob
      s3cmd_read_only: true
      s3cmd_default: true
```

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
