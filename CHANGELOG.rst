==========================
EPFL_SI.RHEL Release Notes
==========================

.. contents:: Topics


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
