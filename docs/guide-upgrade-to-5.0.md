# Upgrade guide 5.0


## Role firewall
The firewall role was removed in 5.0. You must use an alternative. This guide explains how to migrate to `fedora.linux_system_roles.firewall`."

### 1. Write equivalent rules in dry run

If you had this settings for epfl_si.rhel.firewall:

```yaml
firewalld_allow_zone_drifting: no

firewalld_zones:

  external:
    source:
      - {ip: 1.2.3.4/32, state: enabled}
    service:
      - {name: ssh, state: enabled}
      - {name: https, state: disabled}
    port:
      - {name: "9100/tcp", state: enabled}
```
You can write an equivalent for fedora.linux_system_roles.firewall:
Add `runtime: false` to every rule to test settings without modifying the firewall yet.
```yaml
firewall:

  - firewalld_conf:
      allow_zone_drifting: false
    runtime: false
    permanent: true  # Must be true to set drifting without errors.

  - zone: external
    state: enabled
    source:
      - 1.2.3.4/32
    runtime: false

  - zone: external
    state: enabled
    service:
      - ssh
    runtime: false

  - zone: external
    state: disabled
    service:
      - https
    runtime: false

  - zone: external
    state: enabled
    port:
      - 9100/tcp
    runtime: false
```

### 2. Save firewall current config
SSH to your controlled node and backup the configuration:

```sh
cp -r /etc/firewalld /etc/firewalld-backup
```

### 3. Run Playbook
Execute the playbook with the new fedora role.

### 4. Check the configuration
SSH to your controlled node and check the firewall configuration. These commands help you see the final result. Verify everthing match your desired state or compare with the backup:

```sh
cat /etc/firewalld/zones/external.xml
diff /etc/firewalld-backup/zones/external.xml /etc/firewalld/zones/external.xml
```
To check multiple zones at once:
```sh
cat /etc/firewalld/zones/external.xml; echo '\n'; cat /etc/firewalld/zones/internal.xml; echo '\n'; cat /etc/firewalld/zones/public.xml; echo '\n'; cat /etc/firewalld/zones/trusted.xml
```

In case something is bad and you want to rollback:
```sh
cp -r /etc/firewalld-backup/* /etc/firewalld
firewall-cmd --reload
```

### 5. Apply new configuration
First remove all the `runtime: false` from the configuration:

```yaml
firewall:

  - firewalld_conf:
      allow_zone_drifting: false
    permanent: true  # Must be true to set drifting without errors.

  - zone: external
    state: enabled
    source:
      - 1.2.3.4/32

  - zone: external
    state: enabled
    service:
      - ssh

  - zone: external
    state: disabled
    service:
      - https

  - zone: external
    state: enabled
    port:
      - 9100/tcp
```

### 6. Remove the backup
Don't forget to remove the backup from earlier:
```sh
rm -rf /etc/firewalld-backup
```
