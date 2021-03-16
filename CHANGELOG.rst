==========================
EPFL_SI.RHEL Release Notes
==========================

.. contents:: Topics


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
