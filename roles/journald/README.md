Role Journald
==============

A role to manage journald options and restart the service.

When activating the "persistent" storage, this role will ensure that */var/log/journal* directory is created.


Requirements
------------

None


Role Variables
--------------

For more information on journald configuration, please visite the [official documentation](https://www.freedesktop.org/software/systemd/man/journald.conf.html#Storage=)

Here are the defaults values:

* Storage: "auto"
* Compress: "yes"
* Seal: "yes"
* SplitMode: "uid"
* SyncIntervalSec: "5m"
* RateLimitInterval: "30s"
* RateLimitBurst: "1000"
* SystemMaxUse: ""
* SystemKeepFree: ""
* SystemMaxFileSize: ""
* RuntimeMaxUse: ""
* RuntimeKeepFree: ""
* RuntimeMaxFileSize: ""
* MaxRetentionSec: ""
* MaxFileSec: "1month"
* ForwardToSyslog: "yes"
* ForwardToKMsg: "no"
* ForwardToConsole: "no"
* ForwardToWall: "yes"
* TTYPath: "/dev/console"
* MaxLevelStore: "debug"
* MaxLevelSyslog: "debug"
* MaxLevelKMsg: "notice"
* MaxLevelConsole: "info"
* MaxLevelWall: "emerg"
* LineMax: "48K"


Dependencies
------------

None

Example Playbook
----------------

    - hosts: servers
      roles:
         - epfl_si.rhel.journald
           vars:
             journald_options:
               Storage: persistent
               SystemMaxUse: 1G


License
-------

GPLv3

Author Information
------------------

laurent.indermuehle@epfl.ch
