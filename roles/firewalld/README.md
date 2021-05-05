Role Firewalld
==============

A role to manage firewalld. It allow to create new zone and adding sources, ports, services and interfaces to zones.

All resources can be deleted using a `state: disabled` argument. The only exception is the zones created by this role.


Requirements
------------

* `iptables` on RHEL7
* A Python2 interpreter on RHEL7 (because firewalld bindings with python3 are missing)
* `nftable` on RHEL8
* A python3 interpreter on RHEL8

This firewall backend can't be configured.


Role Variables
--------------

### Configuration

* firewalld_default_zone (string)
  * default: public
  * description: The default zone used if an empty zone string is used.
* firewalld_cleanup_on_exit
  * default: yes
  * description: If set to no or false the firewall configuration will not get cleaned up on exit or stop of firewalld
* firewalld_lockdown
  * default: no
  * description: If set to enabled, firewall changes with the D-Bus interface will be limited to applications that are listed in the lockdown whitelist. The lockdown whitelist file is lockdown-whitelist.xml
* firewalld_ipv6_rpfilter
  * default: yes
  * description: Performs a reverse path filter test on a packet for IPv6. If a reply to the packet would be sent via the same interface that the packet arrived on, the packet will match and be accepted, otherwise dropped. The rp_filter for IPv4 is controlled using sysctl.
* firewalld_individual_calls
  * default: no
  * description: Do not use combined -restore calls, but individual calls. This increases the time that is needed to apply changes and to start the daemon, but is good for debugging.
* firewalld_log_denied
  * default: off
  * description: Add logging rules right before reject and drop rules in the INPUT, FORWARD and OUTPUT chains for the default rules and also final reject and drop rules in zones. Possible values are: all, unicast, broadcast, multicast and off.
* firewalld_flush_all_on_reload
  * default: yes (RHEL 8+ only)
  * description: Flush all runtime rules on a reload. In previous releases some runtime configuration was retained during a reload, namely; interface to zone assignment, and direct rules. This was confusing to users. To get the old behavior set this to "no".
* firewalld_rfc3964_ipv4
  * default: yes (RHEL 8+ only)
  * description: As per RFC 3964, filter IPv6 traffic with 6to4 destination addresses that correspond to IPv4 addresses that should not be routed over the public internet.
* firewalld_allow_zone_drifting
  * default: yes
  * description: Older versions of firewalld had undocumented behavior known as "zone drifting". This allowed packets to ingress multiple zones - this is a violation of zone based firewalls. However, some users rely on this behavior to have a "catch-all" zone, e.g. the default zone. You can enable this if you desire such behavior. It's disabled by default for security reasons. Note: If "yes" packets will only drift from source based zones to interface based zones (including the default zone). Packets never drift from interface based zones to other interfaces based zones (including the default zone). Possible values; "yes", "no". Defaults to "yes".

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

None


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
