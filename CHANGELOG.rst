==========================
EPFL_SI.RHEL Release Notes
==========================

.. contents:: Topics


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
