ohmyzsh
=========

Install oh-my-zsh, some custom plugins and a custom theme.

This role won't change the shell of the user. To activate oh-my-zsh, change the user shell to \*/bin/zsh* But it will overwrite the \*\~/.zshrc* file.


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
* ohmyzsh_disable_auto_title
  * default: false
  * type: bool
  * description: Let you disable the oh-my-zsh function that update the window title triggered by some commands.
* ohmyzsh_title
  * default: ""
  * type: string
  * description: Let you set a window title.
* ohmyzsh_custom_functions
  * default: []
  * type: list
  * description: A list of function you want to add to your .zshrc.


Dependencies
------------

None

Example Playbook
----------------


```yaml
---
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
        ohmyzsh_disable_auto_title: true
        ohmyzsh_title: a-test-title
        ohmyzsh_custom_functions:
          - |
            function ssh()
            {
              echo -ne '\e[22t'
              /usr/bin/ssh "$@"
              echo -ne '\e[23t'
            }
```

License
-------

MIT

Author Information
------------------

laurent.indermuehle@epfl.ch
