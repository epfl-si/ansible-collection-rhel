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
* group (string optional)
  * default: Same as user name
  * description: In case the group must be different than the user name
* system (bool)
  * default: no
  * description: If 'yes', indicates that the group/user created is a system group/user. It means the automatic uid/gid generated will be different. Generaly less than 1000 for system users.
* uid (int optional)
  * default: Automatic
  * description: Useful to have same user id accross multiple servers. Prevent issues with permission if files are exchanged between servers.
* gid (int)
  * default: same as uid
  * description: In case you want a gid different than the uid
* shell (string)
  * default: /bin/bash
  * description: The default shell the user will use at login.
* home (path)
  * default: (null)
  * description: Set the user's home directory
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


### role variables vs role parameters

Do note the small difference:

```yaml
# Role vars
- role: epfl_si.rhel.user
  vars:
    name: my_user

# Role parameters
- role: epfl_si.rhel.user
  name: my_user
```

This is VERY important. Do NOT use roles variables if you wish to create multiples users. If you do that, the variables will be merged because their scope is the entire playbook. This is an undocumented behavior of Ansible. More details on this [Github issue #50278](https://github.com/ansible/ansible/issues/50278)


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
