user
=========

Create specified user, sets its default shell, manage the authorized_keys file and sudo rules.
This role handle one user at a time. Call this role multiples times to create many users.

Requirements
------------

None

Role Variables
--------------

* user (string)
  * default: none **required**
  * description: The name of the user to create/configure
* shell (string)
  * default: bash
  * description: The default shell the user will use at login. bash is translated as */bin/bash*. Supported options: `bash`, `zsh`
* path_add (list of string)
  * default: none **required** if `path_add` is set
    description: A list of path to add to the global $PATH variable. `path_add` and `path` are mutualy exclusive.
* path: (string)
  * default: none **required** if `path`is set
  * description: Set this to enforce a fixed path. `path_add` and `path` are mutualy exclusive.
* authorized_keys: (dictionary)
  * exlusive (bool)
    * default: false
    * description: Whether to remove all other non-specified keys from authorized_keys file
  * keys (list of dictionary)
    * "id" (dictionary)
      * default: none **required**
      * description: Name of the user. Only purpose is to reuse an existing dictionary
        * state (string)
          * default: present
          * description: In case exclusive is set to no, allow to remove a key by using `absent`
        * comment (string optional)
          default: none
          description: The name or email of the owner of the key
        * key (string required)
          description: The SSH public key. E.G. "ssh-rsa AAAAB..." or "ssh-ed25519 AAAAC3Nz...."


### Tips for public keys deduplication in inventory

To avoid repeating the dictionary of public keys, you can create a dictionary at the top level of your inventory:

```yaml
admins_pub_keys:
  user1:
    comment: 'user1@example.com'
    key: 'ssh-rsa AAAAB1234'
  user2:
    comment: 'user2 on computer_01'
    key: 'ssh-ed25519 AAAAB7890'
```

and then reference it in the `authorized_keys.keys` variable:

```yaml
- hosts: servers
  roles:
     - role: epfl_si.rhel.user
       vars:
        user: my-user
        authorized_keys:
          keys:
            - "{{ admins_pub_keys.user1 }}"
            - "{{ admins_pub_keys.user2 }}"
```


Dependencies
------------

none


Example Playbook
----------------

```yaml
- hosts: servers
  roles:
     - role: epfl_si.rhel.user
       vars:
        user: my-user
        shell: zsh
        path_add: ['usr/local/bin']
        authorized_keys:
          exlusive: true
          keys:
            - comment: 'user1@example.com'
              key: 'ssh-rsa AAAAB1234'
        sudo:
          - sudoers_file: 20-my-user
            hosts: ALL
            as: sysadm
            commands: ['cmd1', 'cmd2']
            nopasswd: true
```

License
-------

GPLv3

Author Information
------------------

laurent.indermuehle@epfl.ch