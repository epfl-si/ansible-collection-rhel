# Ansible Collection - epfl_si.rhel

Collection of Ansible roles to setup and manage components of RHEL like ntp, sshd, users, ...


## Goal and target audiance

The goal is to help system administrators install and configure their RHEL servers. Thinking first for EPFL, most roles will have default values adapted for our virtualized infrastructure. But we hope it could be useful for anyone.

You are welcome to suggest improvements either by opening a issue or via a push request.

This collection was created before we came across https://github.com/linux-system-roles. We will periodically evaluate their progress and eventually use some of their roles.


## How to include the collection

In your playbook repository, add this to the *collections/requirements.yml* file:

```yaml
---
collections:
  - name: epfl_si.rhel
    version: 1.1.3
```

Be sure to add the path you want to download collections to is present in your *ansible.cfg* file:

```ini
[defaults]
collections_path = ./collections:~/.ansible/collections/ansible_collections
```

Then run:

```bash
ansible-galaxy collection install -r collections/requirements.yml --collections-path ./collections
```

## Roles documentation

Each role has it's own README.md


## Testing

Tests are done using [Molecule](https://molecule.readthedocs.io) with the Podman driver. Because we wants to test communications between containers using IP address, we [must use rootfull containers](https://www.redhat.com/sysadmin/container-networking-podman).

When writing this, Ansible colletions are fairly new and the question about how to update and test roles inside a collection is still discussed by the community. Also, this repository is hosted on GitHub but we only have experience with Gitlab CI. So adaptations could be necessary in the future.

In order to run systemd services inside Podman, we must mount various volumes, disabling Selinux labelling and add capabilities:

```yaml
  - name: node1
    registry: {url: registry.access.redhat.com}
    image: ubi8/ubi-init
    tmpfs:
      - /run  # for SystemD
      - /tmp  # for SystemD
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:ro  # for SystemD
    capabilities:
      - SYS_ADMIN  # for SystemD
      - NET_ADMIN  # for FirewallD + VIP testing
    command: "/usr/sbin/init"
    security_opts:
      - label=disable  # for SystemD
```

Each role contains its own tests. To use Molecule:

```bash
sudo -i  # Remember, we need rootfull containers
cd roles/<name>
molecule test -s <scenario>
```

If you want a running environement to debug your changes:

```bash
sudo -i
cd roles/<name>
molecule converge -s <scenario>
molecule login -s <scenario> -h <node-name>
```

## Publishing

Atm, no automation, everything is done from your computer:

1. Bump the version in `galaxy.yml`
1. `antsibull-changelog lint`
1. `antsibull-changelog release --version <ver>`
1. `git commit -m "Release version <ver>"`
1. `git tag <ver>`
1. `ansible-galaxy collection build`
1. `ansible-galaxy collection publish ./epfl_si-rhel-<ver>.tar.gz --token=<token>`
