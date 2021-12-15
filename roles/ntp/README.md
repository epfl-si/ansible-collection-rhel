NTP
=========

Install NTP and configure it to use EPFL's NTP servers

DEPRECATED
----------

Use redhat.rhel_system_roles.timesync or https://github.com/linux-system-roles/timesync instead


Requirements
------------

None


Role Variables
--------------

None


Dependencies
------------

None


Example Playbook
----------------

    - hosts: servers
      roles:
         - epfl_si.rhel.ntp


License
-------

MIT

Author Information
------------------

laurent.indermuehle@epfl.ch
