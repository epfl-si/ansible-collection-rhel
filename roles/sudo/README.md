Role Sudo
=========

Manage sudoers drop-in files.

Requirements
------------

The user must exists. This role doesn't verify if it is present.

Role Variables
--------------

* sudoers_file
    * default: none **required**
    * type: string
    * description: The name of the drop-in file to install in */etc/sudoers.d/*. The file can start with a digit and a dash, e.g. 10-myuser. The files are loaded in ascending order.
* rules
    * default: none **required**
    * type: list of objects
    * description : The list of rules to install for the user. Each rules will become a line in the suders drop-in file.
    * user
        * default: none **required**
        * type: string
        * description: The user or group allowed to use the rule. May be a username, a group name prefixed with %, a numeric UID prefixed with # or numéric GID prefixed with %#
    * host
        * default: ALL
        * type: string
        * description: Optional host on which the command will be allowed. May be a hostname, IP address or a whole network (e.g. 10.0.0.0/20) but not 127.0.0.1
    * runas
        * default: ALL
        * type: string
        * description: This optional parameter controls the target user sudo will run the command as. If omitted, the user will only be permitted to run commands as root.
    * commands
        * default: none **required**
        * type: list
        * description: The list of command to authorized. Wildcard is possible using an asterisk. Prefer to use full path for commands, e.g. /usr/bin/systemctl * mariadb*
    * nopasswd
        * default: False
        * type: bool
        * Description: Whether the user can use the commands without giving a password.

Dependencies
------------

None

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: servers
  roles:
    - role: epfl_si.rhel.sudo
      sudoers_file: 20-my-user
      rules:
        - user: my_user
          commands: ['cmd1', 'cmd2']
          nopasswd: true
```

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
