Role Firewalld
==============

A role to manage firewalld


Requirements
------------

None


Role Variables
--------------

### Add sources to a zone

To add a source, no other argument than `source` are required.
If you wants to empty a zone's sources, first set all sources to disabled, run the playbook, then you can remove the `firewalld_zone_sources` variable from your inventory. If, instead, you start by deleting the variable, the tasks will be skipped and your sources will still be present in the node's firewalld zone.

Be aware that if you change permanent and immediate to false, the rules will be lost on reboot. Currently this role doesn't manage these cases.

```yaml
firewalld_zone_sources:
  external:
    source:
      - ip: 10.80.10.10/32
        state: enabled/disabled Optionnal(Default=enabled)
        permanent: true/false Optionnal(Default=true)
        immediate: true/false Optionnal(Default=true)
      - 10.80.10.11/32
        state: enabled/disabled Optionnal(Default=enabled)
        permanent: true/false Optionnal(Default=true)
        immediate: true/false Optionnal(Default=true)
  public:
    [...]
```

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

    - hosts: servers
      roles:
         - epfl_si.rhel.firewalld


License
-------

MIT

Author Information
------------------

laurent.indermuehle@epfl.ch
