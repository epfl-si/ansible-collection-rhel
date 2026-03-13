# Ansible Collection - epfl_si.rhel

Collection of Ansible roles to setup and manage components of RHEL like sshd, users, sudo,...


## Goal and target audience

The goal is to help system administrators install and configure their RHEL servers.

You are welcome to suggest improvements either by opening a issue or via a pull request.

This collection was created before we came across https://github.com/linux-system-roles. We will periodically evaluate their progress and eventually use some of their roles.


## How to include the collection

In your playbook repository, add this to the *collections/requirements.yml* file:

```yaml
---
collections:
  - name: epfl_si.rhel
    version: 4.2.0
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

### Install Ansible Controller

On the controller node, we prefer to use a virtualenv:

```bash
sudo yum install python3 python3-virtualenv
mkdir -p ~/python-venv/ansible
virtualenv --python=python3 ~/python-venv/ansible
source ~/python-venv/ansible/bin/activate
python -m  pip install --upgrade pip
pip install \
  ansible \
  ansible-lint \
  antsibull-changelog \
  molecule \
  yamllint \
  selinux \
  psutil \
  argcomplete
```


### Run tests

Tests are done using [Molecule](https://molecule.readthedocs.io) with the Podman driver. Because we wants to test communications between containers using IP address, we [must use rootfull containers](https://www.redhat.com/sysadmin/container-networking-podman).

Each role contains its own tests. To use Molecule:

```bash
sudo -i  # Remember, we need rootfull containers
source ~/python-venv/ansible/bin/activate
cd roles/<name>
molecule test -s <scenario>
```

If you want a running environement to debug your changes:

```bash
sudo -i
source ~/python-venv/ansible/bin/activate
cd roles/<name>
molecule converge -s <scenario>
molecule login -s <scenario> -h <node-name>
```

## Publishing

ATM, no automation, everything is done from your computer. To find your token, go to [https://galaxy.ansible.com/me/preferences](https://galaxy.ansible.com/me/preferences)

1. Bump the version in `galaxy.yml`
1. Add a new file in `changelogs/fragments/release_<ver>.yaml` to add the `release_summary` or any other changes to announce.
1. `python3 -m pip install --user --force-reinstall antsibull-changelog`
1. `antsibull-changelog lint`
1. `antsibull-changelog release --version <ver>`
1. `git add .`
1. `git commit -m "Release version <ver>"`
1. `git tag -n|tail`
1. `git tag <ver> -m "Release version <ver>"`
1. `ansible-galaxy collection build`
1. `ansible-galaxy collection publish ./epfl_si-rhel-<ver>.tar.gz --token=<token>`
1. `rm ./epfl_si-rhel-<ver>.tar.gz`
1. `git push --tags`
1. `git push`
