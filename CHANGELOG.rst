==========================
EPFL_SI.RHEL Release Notes
==========================

.. contents:: Topics


v1.5.0
======

Major Changes
-------------

- s3cmd - Stop intalling extra repositories and Python 3.8 on RHEL7. Instead we add pip3 to the requirements. This means you have to activate EPEL and install the packages python3 and python3-pip yourself now.

Minor Changes
-------------

- firwalld - Add idempotency to task that validate the configuration

v1.4.7
======

Minor Changes
-------------

- firewalld - Add support for RHEL7. It worked previously but with warning.

Bugfixes
--------

- firewalld - Configuration validation now displays errors and warnings

v1.4.6
======

Minor Changes
-------------

- Raise supported version up to Ansible 4 (ansible-core 2.11)

Bugfixes
--------

- user - Fix .zshrc from ohmyzsh overwritten by accident
- user - Fix user PATH definition

v1.4.5
======

Bugfixes
--------

- sshd - Fix missing new line is sshd configuration

v1.4.4
======

Minor Changes
-------------

- sshd - Add option to permit root login

v1.4.3
======

Bugfixes
--------

- firewalld - Fix non-root ansible_user unable to reload firewalld

v1.4.2
======

Bugfixes
--------

- ohmyzsh - Fix zsh configuration overwritten each run

v1.4.1
======

Bugfixes
--------

- user - Fix a bug in AWX/Tower when transforming string to list using map that printed the generator object do_map at 0x7.... instead of the string

v1.4.0
======

Release Summary
---------------

Many roles have been refactored to be simpler to use. With less relying on the inventory it's now easier to understand what a role will do.

Major Changes
-------------

- ohmyzsh - New role with a pre-build .oh-my-zsh for a fast installation
- sudo - New role that manages sudoers.d drop-in files
- user - New role that creates a linux user and manage $PATH for bash and zsh

Breaking Changes / Porting Guide
--------------------------------

- s3cmd - The role now only handle one user and one bucket at a time.

Removed Features (previously deprecated)
----------------------------------------

- users_linux - This role is deleted. Use epfl_si.rhel.user, epfl_si.rhel.ohmyzsh and epfl_si.rhel.sudo instead

v1.3.0
======

Major Changes
-------------

- users_linux - GID may be different than UID now. With this change, you have to rename your variables sysadm_id and appadm_id to sysadm_uid and appadm_uid

v1.2.1
======

Bugfixes
--------

- Journald - Fix permission to create folder /var/log/journal

v1.2.0
======

Minor Changes
-------------

- Journald - New role to manage systemd journald
- Raise maximum Ansible version supported to 2.10+ since it's the versionused by our molecule tests

v1.1.3
======

Bugfixes
--------

- firewalld - Fix syntax of inclusion of external collections
- s3cmd - Install python3 package instead of python38 on RHEL8

v1.1.2
======

Bugfixes
--------

- s3cmd - Fix tasks with missing escalation of privileges to hang forever

v1.1.1
======

v1.1.0
======

Minor Changes
-------------

- s3cmd - New role with supports for multiples buckets configuration

Bugfixes
--------

- Fix Podman Network creation when no network are specified

v1.0.4
======

Major Changes
-------------

- Change License from MIT to GPLv3

Minor Changes
-------------

- Add a upper limit to the required ansible version to stay in 2.9 (for Tower)
- Tests - Add os detection for RHEL7/8 for containers provionning
- Tests - Cleanup scenario files
- Tests - Use a generalized Dockerfile to build containers

Bugfixes
--------

- Doc - Fix main variable name from ``firewalld_zone`` to ``firewalld_zones``
- Tests - Fix failure when newtork is undefined
- Tests - Fix os detection for CentOS 7/8 when containers are provisionned
