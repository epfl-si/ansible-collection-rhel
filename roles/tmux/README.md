Role Tmux
==============

A role to manage tmux confirmation for a specific user. Because this role is designed to be called in a loop for multiple user, it doesn't install tmux.


Requirements
------------

- tmux (this role doesn't install the package)
- GIT (if `tmux_with_tpm` is set to true)


Role Variables
--------------

The role parameters are in meta/argument_specs.yml or use the command `ansible-doc --type role tmux` to read them.

Dependencies
------------

None

Example Playbook
----------------

```yaml
---
- hosts: servers
  pre_tasks:

    - name: Install tmux and GIT
      ansible.builtin.package:
        name:
          - tmux
          - git
        state: present

  roles:

    # If ansible_user is not root, use `become: true`
    - role: epfl_si.rhel.tmux
      tmux_user: my_user
      tmux_with_tpm: true
      tmux_options:
        - bind-key -n F4 copy-mode
        - set-window-option -g automatic-rename off
        - set-option -g set-titles off
```


License
-------

MIT

Author Information
------------------

laurent.indermuehle@epfl.ch
