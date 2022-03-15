user
=========

Create specified user, set its default shell, manage the authorized_keys file and sudo rules.
This role handle one user at a time. Call this role multiple times to create many users.

This role must be run with `become: true`!


Requirements
------------

* The shell specified must be installed
* You must source `~/.common_profile` in your `~/.bash_profile` or `~/.zshrc` (epfl_si.rhel.ohmyzsh takes care of that for you)


Role Variables
--------------

The role parameters are explained in *meta/argument_specs.yml* or you can use the command `ansible-doc --type role epfl_si.rhel.user` to read them.


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


Dependencies
------------

none


Example Playbook
----------------

Basic example :

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
    user_umask: '0027'
```


## Example with ssh_keys stored in the group_vars

To save you from repeating SSH public keys for every user, you can add them once in the group_vars. To do so, add in *group_vars/all/ssh_keys* a variables with a dictionnary of your users:

```yaml
---
ssh_pub_keys:
  user1:
    comment: 'user1@example.com'
    ssh_key: 'ssh-ed25519 AAAAC01234'
  user2:
    comment: 'user2@example.com'
    ssh_key: 'ssh-ed25519 AAAAC45678'
```

Then, in your playbook:

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
          - "{{ ssh_pub_keys.user1 }}"
          - "{{ ssh_pub_keys.user2 }}"

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
          - "{{ ssh_pub_keys.user1 }}"
```

License
-------

MIT

Author Information
------------------

laurent.indermuehle@epfl.ch
