Role Name
=========

This role install SSHD and allow to overwrite the default configuration using drop-in configuration files.

Requirements
------------

None

Role Variables
--------------

The role parameters are in meta/argument_specs.yml or use the command `ansible-doc --type role sshd` to read them.

Dependencies
------------

None

Example Playbook
----------------

```yml
- name: Playbook
  hosts: servers
  tasks:
      - name: Import sshd role
        become: true
        ansible.builtin.import_role:
          name: epfl_si.rhel.sshd
```

License
-------

MIT

Author Information
------------------

laurent.indermuehle@epfl.ch
