Role Journald
==============

A role to manage journald options and restart the service.

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
* forwardToConsole: "no"
* forwardToKMsg: "no"
* forwardToSyslog: "no"
* forwardToWall: "yes"
* lineMax: "48K"
* maxFileSec: "1month"
* maxLevelConsole: "info"
* maxLevelKMsg: "notice"
* maxLevelStore: "debug"
* maxLevelSyslog: "debug"
* maxLevelWall: "emerg"
* maxRetentionSec: ""
* rateLimitBurst: "10000"
* rateLimitIntervalSec: "30s"
* readKMsg: "yes"
* runtimeKeepFree: ""
* runtimeMaxFiles: "100"
* runtimeMaxFileSize: ""
* runtimeMaxUse: ""
* seal: "yes"
* splitMode: "uid"
* storage: "auto"
* syncIntervalSec: "5m"
* systemKeepFree: ""
* systemMaxFiles: "100"
* systemMaxFileSize: ""
* systemMaxUse: ""
* tTYPath: "/dev/console"



Dependencies
------------

None

Example Playbook
----------------

    - hosts: servers
      roles:
         - epfl_si.rhel.journald
           vars:
             journald_storage: "persistent"
             journald_systemMaxUse: "1G"


License
-------

GPLv3

Author Information
------------------

laurent.indermuehle@epfl.ch
