Role Firewalld
==============

A role to manage firewalld. It allow to create new zone and adding sources, ports, services and interfaces to zones.

All resources can be deleted using a `state: disabled` argument. The only exception is the zones created by this role.


Requirements
------------

* `iptables` on RHEL7
* `nftable` on RHEL8

This firewall backend can't be configured.


Role Variables
--------------

### Add sources to a zone

To add a source, no other argument than `source` are required.
If you wants to empty a zone's sources, first set all sources to disabled, run the playbook, then you can remove the `firewalld_zone_sources` variable from your inventory. If, instead, you start by deleting the variable, the tasks will be skipped and your sources will still be present in the node's firewalld zone.

Be aware that if you change permanent and immediate to false, the rules will be lost on reboot. Currently this role doesn't manage these cases.

```yaml
firewalld_zones:
  external:
    source:
      - ip: 10.80.10.10/32
        state: enabled/disabled Optionnal(Default=enabled)
        permanent: true/false Optionnal(Default=true)
        immediate: true/false Optionnal(Default=true)
      - ip: 10.80.10.11/32
  public:
    [...]
```


### Add interfaces to a zone

This is similar to adding a source. Only add an interface to a single zone. If you add it many times, the last zone listed will win.

```yaml
firewalld_zones:
  external:
    source:
      - ip: 10.80.10.10/32
    interface:
      - name: eth0
        state: enabled/disabled Optionnal(Default=enabled)
        permanent: true/false Optionnal(Default=true)
        immediate: true/false Optionnal(Default=true)
      - name: eth1
      - {name: eth2, state: disabled}
  public:
    [...]
```


### Add a service to a zone

This is similar to adding a source except you must provide a name instead of a ip key:

```yaml
firewalld_zones:
  external:
    source:
      - ip: 10.80.10.10/32
    service:
      - name: ssh
        state: enabled/disabled Optionnal(Default=enabled)
        permanent: true/false Optionnal(Default=true)
        immediate: true/false Optionnal(Default=true)
      - {name: cockpit, state: disabled}
  public:
    [...]
```


### Add a port or range to a zone

Exactly the same as adding a service. Here's an example:

```yaml
firewalld_zones:
  external:
    source:
      - ip: 10.80.10.10/32
    port:
      - name: "8888/tcp"
        state: enabled/disabled Optionnal(Default=enabled)
        permanent: true/false Optionnal(Default=true)
        immediate: true/false Optionnal(Default=true)
      - name: "12000-12099/tcp"
      - {name: "443/tcp", state: disabled}
  public:
    [...]
```


### Create a new zone

If you add a zone to the list of zones in your inventory that is not present in firewalld, it will be created and the service reloaded. This role doesn't handle zone deletions.



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

GPLv3

Author Information
------------------

laurent.indermuehle@epfl.ch
