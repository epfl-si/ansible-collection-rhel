ohmyzsh
=========

Install oh-my-zsh, its plugins and themes. But using local cache. Otherwise downloading each resource on Github takes severals minutes. When managing multiple user, the speed gain is very noticeable.

This role won't change the shell of the user. To activate oh-my-zsh, change the user shell to */bin/zsh*!

This role install the following custom plugins:

* zsh-autosuggestions
  * From [github.com/zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
* zsh-completions
  * From [github.com/zsh-users/zsh-completions](https://github.com/zsh-users/zsh-completions)
* zsh-syntax-highlighting
  * From [github.com/zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

This role install the following custom theme:

* mh-hostname
  * From [mh-hostname.zsh-theme](http://raw.githubusercontent.com/Honiix/oh-my-zsh/master/themes/mh-hostname.zsh-theme)

To add more plugins and themes, edit the *Makefile*


Requirements
------------

None


Role Variables
--------------

* ohmyzsh_user
  * default: none **required**
  * type: string
  * description: The user for whom to install oh-my-zsh
* ohmyzsh_theme
  * default: robbyrussell
  * type: string
  * description: One of the builtin themes from [here](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes)
* ohmyzsh_plugins
  * default: ['git', 'z', 'zsh-autosuggestions', 'zsh-completions', 'zsh-syntax-highlighting']
  * type: list
  * description: List of plugins to activate.

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
        ohmyzsh_user: user_01
        ohmyzsh_theme: mh-hostname
        ohmyzsh_plugins:
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


How to update the static oh-my-zsh and custom plugins/themes
------------------------------------------------------------

1. Delete the file *files/ohmyzsh.tar.gz*
1. Run `make`
1. Commit (and release a new version of the collection)
