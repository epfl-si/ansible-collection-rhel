Role Name
=========

Install and configure s3cmd

This role handle multiple buckets configure on the same computer at the same time. The defaults one can be use with `s3cmd` command. The other one must be specified `s3cmd --config=~/.s3cfg-my-secondary-bucket`

Requirements
------------

None

Role Variables
--------------

* `s3cmd_buckets` (dict):
* `s3cmd_buckets.bucketname` (dict): Name of the bucket. Will be added to the config file name: `.s3cfg-bucketname`
* `s3cmd_buckets.bucketname.s3cmd_users` (list): The user you wish to create a *.s3cfg* file for.
* `s3cmd_buckets.bucketname.s3_access_key_rw`: (string required) Read-Write access key
* `s3cmd_buckets.bucketname.s3_secret_key_rw`: (string required) Read-Write access key
* `s3cmd_buckets.bucketname.s3_access_key_ro`: (string required) Read-Only access key
* `s3cmd_buckets.bucketname.s3_secret_key_ro`: (string required) Read-Only access key
* `s3cmd_buckets.bucketname.s3_host_bucket`: default bucket (required)
* `s3cmd_buckets.bucketname.s3_human_readable_sizes`: true/false to display file size in k/M/G instead of bites
* `s3cmd_buckets.bucketname.s3_host_base`: The URI of your s3 server
* `s3cmd_buckets.bucketname.s3_website_endpoint`: The API URI

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

License
-------

GPLv3

Author Information
------------------

laurent.indermuehle@epfl.ch
