Role Name
=========

Secures SSHD by prohibiting root and connections
using password. Enables connection auditing since several users log
in to the same account (sysadm, appadm, ...)

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
         - indermue.el8.sshd

License
-------

MIT

Author Information
------------------

laurent.indermuehle@epfl.ch
