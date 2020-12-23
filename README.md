# Ansible Collection - epfl_si.rhel

Collection of Ansible roles to setup and manage components of RHEL like ntp, sshd, users, ...


## How to include the collection

In your playbook repository, add this to the *collections/requirements.yml* file:

```yaml
---
collections:
  - name: epfl_si.rhel
    version: 1.0.0

```

Then run:

```bash
ansible-galaxy collection install -r collections/requirements.yml
```
