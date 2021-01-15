# Ansible Collection - epfl_si.rhel

Collection of Ansible roles to setup and manage components of RHEL like ntp, sshd, users, ...


## How to include the collection

In your playbook repository, add this to the *collections/requirements.yml* file:

```yaml
---
collections:
  - name: epfl_si.rhel
    version: 1.0.1

roles
  - name: gantsign.oh-my-zsh
    version: 2.3.0
```

Then run:

```bash
ansible-galaxy collection install -r collections/requirements.yml
```


## Testing

Tests are done using [Molecule](https://molecule.readthedocs.io) with the Podman driver. Because we wants to test communications between containers using IP address, we [must use rootfull containers](https://www.redhat.com/sysadmin/container-networking-podman).

When writing this, Ansible colletions are fairly new and the question about how to update and test roles inside a collection is still discussed by the community. Also, this repository is hosted on GitHub but we only have experience with Gitlab CI. So adaptations could be necessary in the future.

Red Hat ubi8-init image doesn't provide Python which is required by Ansible. To build this image locally, run the script `build_container.sh`.

In order to run systemd services inside Podman, we must mount various volumes, disabling Selinux labelling and add capabilities:

```yaml
  - name: node1
    image: localhost/ubi8-init-molecule:1.0.0
    tmpfs:
      - /run  # for SystemD
      - /tmp  # for SystemD
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:ro  # for SystemD
    capabilities:
      - SYS_ADMIN  # for SystemD
      - NET_ADMIN  # for FirewallD + VIP testing
    command: "/usr/sbin/init"
    pre_build_image: true  # To prevent molecule from building the image itself
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
podman ps -a
podman exec -it <container-name> bash
```
