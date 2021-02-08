users_linux
=========

Create linux accounts.

Requirements
------------

None


Role Variables
--------------

See *defaults/main.yml* for the list of variables.

At minimum, you should define user ssh keys:

```yaml
admins_pub_keys:
  user1:
    state: 'present'
    email: 'user1@example.com'
    key: 'ssh-ed25519 AAAAC1apoadsufopadsfiumqewrnqwemnropuqiadsfufiad'
  user2:
    state: 'present'
    email: 'user2@example.com'
    key: 'ssh-ed25519 AAAAC2apoadsufopadsfiumqewrnqwemnropuqiadsfufiad'

sysadm_authorized_keys:
  - "{{ admins_pub_keys.user1 }}"
  - "{{ admins_pub_keys.user2 }}"
appadm_authorized_keys: []
```


Dependencies
------------

role: gantsign.oh-my-zsh


Example Playbook
----------------

    - hosts: servers
      roles:
         - epfl_si.rhel.users_linux


License
-------

MIT

Author Information
------------------

laurent.indermuehle@epfl.ch
