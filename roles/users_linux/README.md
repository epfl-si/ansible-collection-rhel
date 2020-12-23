users_linux
=========

Create linux accounts.

Requirements
------------

None


Role Variables
--------------

See *defaults/main.yml* for the list of variables.


Dependencies
------------

role: gantsign.oh-my-zsh


Example Playbook
----------------

    - hosts: servers
      roles:
         - epfl_si.rhel.users_linux


License
-------

MIT

Author Information
------------------

laurent.indermuehle@epfl.ch
