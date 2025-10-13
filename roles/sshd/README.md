Role Name
=========

Secures SSHD by prohibiting login as root and login using passwords.
Enables connection auditing since several users log
in to the same account (sysadm, appadm, ...)

Requirements
------------

None

Role Variables
--------------

sshd_permit_root_login : Default false

Dependencies
------------

None

Example Playbook
----------------


    - hosts: servers
      tasks:
         - name: Import sshd role
           become: true
           ansible.builtin.import_role:
             name: epfl_si.rhel.sshd

License
-------

MIT

Author Information
------------------

laurent.indermuehle@epfl.ch


## TODO
LogLevel VERBOSE           # INFO by default, VERBOSE gives more details, like key line in ~/.ssh/authorized_keys used.
PasswordAuthentication no  # disable password authentication for security reasons
