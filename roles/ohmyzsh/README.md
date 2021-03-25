ohmyzsh
=========

Install oh-my-zsh, its plugins and themes. But using local cache. Otherwise downloading each resource on Github takes severals minutes. When managing multiple user, the speed gain is very noticeable.

Requirements
------------

None


Role Variables
--------------

TODO

Dependencies
------------

None

Example Playbook
----------------


```yaml
- hosts: servers
  roles:
    - role: epfl_si.rhel.ohmyzsh
      vars:
        ohmyzsh:
          user: sysadm
          theme: xx
          plugins:
            - z
            - git
            - zsh-autosuggestions
            - zsh-completions
            - zsh-syntax-highlighting
```

License
-------

GPLv3

Author Information
------------------

laurent.indermuehle@epfl.ch
