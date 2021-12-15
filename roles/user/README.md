user
=========

Create specified user, sets its default shell, manage the authorized_keys file and sudo rules.
This role handle one user at a time. Call this role multiples times to create many users.


Requirements
------------

* The shell specified must be installed
* You must source `~/.common_profile` in your `~/.bash_profile` or `~/.zshrc` (epfl_si.rhel.ohmyzsh takes care of that for you)


Role Variables
--------------

* user_name (string)
  * default: none **required**
  * description: The name of the user to create/configure
* user_uid (int optional)
  * default: Automatic
  * description: Useful to have same user id across multiple servers. Prevent issues with permission if files are exchanged between servers.
* user_shell (string)
  * default: /bin/bash
  * description: The default shell the user will use at login.
* user_home (path)
  * default: (null)
  * description: Set the user's home directory
* user_path_add (list of string)
  * default: (null)
    description: A list of path to add to the global $PATH variable. Useful in case you want to quickly add a path to the user without altering the existing one. Removing a path from this list will also remove it from the user at the next playbook run. This paths are shared between different shell and stored in the ~/.common_profile file. `path_add` and `path` are mutually exclusive.
* user_path: (null)
  * default: none **required** if `path`is set
  * description: Set this to enforce a fixed path. `path_add` and `path` are mutually exclusive.
* user_authorized_keys: (dictionary)
  * exclusive (bool)
    * default: false
    * description: Whether to remove all other non-specified keys from authorized_keys file
  * keys_list (list of dictionary)
    * comment (string optional)
      default: none
      description: The name or email of the owner of the key
    * ssh_key (string required)
      description: The SSH public key. E.G. "ssh-rsa AAAAB..." or "ssh-ed25519 AAAAC3Nz...."
* user_umask: (int optional)
  * default: omit
  * description: Allow to set a different umask for this user. Do use single quote around the number. Otherwise the value may be set to '22' instead of '022' or '0022'


### role variables vs role parameters

Do note the small difference:

```yaml
---
# Role vars
- role: epfl_si.rhel.user
  vars:
    user_name: my_user

# Role parameters
- role: epfl_si.rhel.user
  user_name: my_user
```

This is VERY important. Do NOT use roles variables if you wish to create multiples users. If you do that, the variables will be merged because their scope is the entire playbook. This is an undocumented behavior of Ansible. More details on this [Github issue #50278](https://github.com/ansible/ansible/issues/50278)


### Tips for public keys deduplication in inventory

To avoid repeating the dictionary of public keys, you can create a dictionary at the top level of your inventory:

```yaml
---
ssh_pub_keys:
  user1:
    comment: 'user1@example.com'
    ssh_key: 'ssh-rsa AAAAB1234'
  user2:
    comment: 'user2 on computer_01'
    ssh_key: 'ssh-ed25519 AAAAB7890'
```

and then reference it in the `user_authorized_keys.keys_list` variable:

```yaml
---
- hosts: servers
  roles:
  - role: epfl_si.rhel.user
    user_name: my-user
    user_authorized_keys:
      keys_list:
      - "{{ ssh_pub_keys.user1 }}"
      - "{{ ssh_pub_keys.user2 }}"
```


Dependencies
------------

none


Example Playbook
----------------

```yaml
---
- hosts: servers
  roles:
  - role: epfl_si.rhel.user
    user_name: my-user
    user_shell: /bin/zsh
    user_path_add: ['usr/local/bin']
    user_authorized_keys:
      exclusive: true
      keys_list:
        - comment: 'user1@example.com'
          ssh_key: 'ssh-rsa AAAAB1234'
```

## Example with inventory inheritance

In case a user is often reused, you can defined it at top level of your playbook and assign it to a variable. Then later you can add other user at different level of your inventory. At playbook level you may call the role multiples times with a different user each time. Or you can define the list of users to manage in the inventory then call this variable in a loop as shown bellow:

In *inventory/group_vars/all/vars*:

```yaml
---
ssh_pub_keys:
  user1:
    comment: 'user1@example.com'
    ssh_key: 'ssh-ed25519 AAAAC01234'
  user2:
    comment: 'user2@example.com'
    ssh_key: 'ssh-ed25519 AAAAC45678'

user_manager:
  user_name: manager
  user_shell: /bin/zsh
  user_home: /home/manager
  user_authorized_keys:
    exclusive: true
    keys_list:
      - "{{ ssh_pub_keys.user1 }}"
      - "{{ ssh_pub_keys.user2 }}"
```

In *inventory/group_vars/subgroup/vars*:

```yaml
---
user_mysql:
  user_name: mysql
  user_shell: /bin/bash
  user_uid: 321
  user_home: /home/mysql
  user_authorized_keys:
    exclusive: true
    keys_list:
      - "{{ ssh_pub_keys.user1 }}"

users:
  - "{{ user_manager }}"
  - "{{ user_mysql }}""
```

In your playbook:

```yaml
---
- name: Manage users
  hosts: all
  tasks:

    - include_role:
        name: epfl_si.rhel.user
      vars:
        user_name: "{{ user_item.username }}"
        user_shell: "{{ user_item.shell | default('') }}"
        user_home: "{{ user_item.home | default('') }}"
        user_uid: "{{ user_item.uid | default(0) }}"
        user_path_add: "{{ user_item.user_path_add | default([]) }}"
        user_path: "{{ user_item.user_path | default('') }}"
        user_authorized_keys: "{{ user_item.user_authorized_keys | default({}) }}"
      loop: "{{ users }}"
      loop_control:
        loop_var: user_item

```

Alternatively:

```yaml
---
- name: Manage users
  hosts: all
  roles:

    - role: epfl_si.rhel.user
      user_name: manager
      user_shell: /bin/bash
      user_home: /home/manager
      user_authorized_keys:
        exclusive: true
        keys_list:
          - "{{ admins_pub_keys.user1 }}"
          - "{{ admins_pub_keys.user2 }}"

    - role: epfl_si.rhel.user
      user_name: mysql
      user_shell: /bin/bash
      user_uid: 321
      user_home: /home/mysql
      user_path_add:
        - /u01/app/mysql/product/mysql-5.7.26/bin
      user_authorized_keys:
        exclusive: true
        keys_list:
          - "{{ admins_pub_keys.user1 }}"
```


License
-------

MIT

Author Information
------------------

laurent.indermuehle@epfl.ch
