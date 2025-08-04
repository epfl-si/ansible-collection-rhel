Role Journald
==============

A role to manage journald options and restart the service.

This role must be run as root

When activating the "persistent" storage, this role will ensure that */var/log/journal* directory is created.


Requirements
------------

None


Role Variables
--------------

For more information on journald configuration, please visite the [official documentation](https://www.freedesktop.org/software/systemd/man/journald.conf.html#Storage= )

Be extra careful to put quotes around the variables to prevent Ansible to convert `yes` into `True`.

To use the following variables, prefix each with "journald_":

* audit: "yes"
* compress: "yes"
* forward_to_console: "no"
* forward_to_kmsg: "no"
* forward_to_syslog: "no"
* forward_to_wall: "yes"
* line_max: "48K"
* max_file_sec: "1month"
* max_level_console: "info"
* max_level_kmsg: "notice"
* max_level_store: "debug"
* max_level_syslog: "debug"
* max_level_wall: "emerg"
* max_retention_sec: ""
* rate_limit_burst: "10000"
* rate_limit_interval_sec: "30s"
* read_kmsg: "yes"
* runtime_keep_free: ""
* runtime_max_files: "100"
* runtime_max_file_size: ""
* runtime_max_use: ""
* seal: "yes"
* split_mode: "uid"
* storage: "auto"
* sync_interval_sec: "5m"
* system_keep_free: ""
* system_max_files: "100"
* system_max_file_size: ""
* system_max_use: ""
* tty_path: "/dev/console"



Dependencies
------------

None

Example Playbook
----------------

    - hosts: servers
      tasks:
         - name: Import role journald
           become: true
           ansible.builtin.import_role:
            name: epfl_si.rhel.journald
           vars:
             journald_storage: "persistent"
             journald_system_max_use: "1G"


License
-------

MIT

Author Information
------------------

laurent.indermuehle@epfl.ch
