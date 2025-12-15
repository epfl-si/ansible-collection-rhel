Role nfs_client
=========

This role will install the package nfs-utils and then let you pass a configuration for a NFS share. Systemd will be used to mount the share on the controlled node.


Requirements
------------

This role must be run with root privileges.

Role Variables
--------------
The role parameters are in meta/argument_specs.yml or use the command `ansible-doc --type role nfs_client` to read them.

Dependencies
------------
None


Example Playbook
----------------

```yaml
---
- hosts: servers
  tasks:
    - name: Import nfs client role
      become: true
      ansible.builtin.import_role:
        name: epfl_si.rhel.nfs_client
      vars:
        nfs_client_mount_point: /mnt/nfs_share
        nfs_client_share: nfs-server.example.com:/mnt/shares/user1
```

License
-------
MIT

Author Information
------------------
[laurent.indermuehle@epfl.ch](mailto:laurent.indermuehle@epfl.ch)
