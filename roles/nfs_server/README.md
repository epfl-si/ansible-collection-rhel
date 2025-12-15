Role Name
=========

Install and configure NFS Server.

Requirements
------------

This role must be run with root privileges.
The shared folder must exists.

Role Variables
--------------

Here is how to add exports for the NFS server:

```yaml
---
nfs_server_exports:
  - /var/lib/nfs1 10.95.95.2 (rw,anonuid=1000,anongid=1000)
```

Dependencies
------------

None


Example Playbook
----------------

```yml
---
- name: Install and configure NFS Server
  hosts: servers
  tasks:
    - name: Install and configure NFS server
      become: true
      ansible.builtin.import_role:
        name: epfl_si/rhel/nfs_server
      vars:
        nfs_server_exports:
          - /var/lib/nfs1 10.95.95.2 (rw,anonuid=1000,anongid=1000)
      tags: nfs_server
```

License
-------

MIT

Author Information
------------------

laurent.indermuehle@epfl.ch
