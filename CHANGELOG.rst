==========================
EPFL_SI.RHEL Release Notes
==========================

.. contents:: Topics


v2.1.0
======

Release Summary
---------------

All journald variables have changed. Every camel cased variables should now be underscore separation and all lower cases.


Major Changes
-------------

- The journald role has all its variables name renamed to respect ansible-lint conventions.

v2.0.3
======

Minor Changes
-------------

- user - Add list to add custom variables to the .common_profile file.

Bugfixes
--------

- nginx - Fix the service not beeing enabled if nginx was already installed

v2.0.2
======

Minor Changes
-------------

- tmux - Add tmux role with support for the plugin manager 'tpm'

v2.0.1
======

Release Summary
---------------

Add functionalities to the role ohmyzsh to allow changing title on your terminal's window and add custom functions to the .zshrc file.

Minor Changes
-------------

- ohmyzsh - Add option to add custom function in the zsh configuration file
- ohmyzsh - Add option to change the terminal title
- ohmyzsh - Add option to disable automatic title

v2.0.0
======

Release Summary
---------------

Because of a breaking change in the role user, this is a major release. The ntp role is removed as annonced in the release 1.8.1.

Minor Changes
-------------

- user - Add options validation (main/argument_specs.yml)
- user - Add tests for every scenario
- user - Enhanced Check mode
- user - Fix linting for ansible-lint 6.0.0

Breaking Changes / Porting Guide
--------------------------------

- To use the new syntax, please modifiy the roles parameters from
  ---
  - name: Create a user
    role: epfl_si.rhel.user:
    user_authorized_keys:
    exclusive: true
    keys_list:
      - comment: user1@example.com
        ssh_key: ssh-rsa AAAAB1234
  To
  ---
  - name: Create a user
    role: epfl_si.rhel.user:
    user_authorized_keys_exclusive: true
    user_authorized_keys:
      - comment: user1@example.com
        ssh_key: ssh-rsa AAAAB1234
- user - Modify user_authorized_keys from dict to list
- user - Modify variable to set authorized_keys as exlusive to be outside of the user_authorized_keys variable
- user - Removed the variable keys_list from user_authorized_keys

Bugfixes
--------

- user - Fix idempotence when changing SSH keys for the root user

v1.9.3
======

Minor Changes
-------------

- user - Only chown the user's home if the user changed. Previously we were always doing it, which was very long if the user has many files.

v1.9.2
======

Release Summary
---------------

The ohmyzsh roles was causing issue because we were changing file permission. This prevented oh-my-zsh to update itself due to all files been makes 'unstaged' by git. During the release of a newer version of the role, Ansible Galaxy refused our new version due to a file, the bundle installer of oh-my-zsh + its plugins, been too big (23MB). The I had now other choice to revert the installation to git clone. The role may become very slow to deploy for the first time. But now 'omz update' should works properly.

Minor Changes
-------------

- ohmyzsh - Change installation method from bundle to git clone

Known Issues
------------

- ohmyzsh - All previous version had a issue that may prevent you to update the custom plugins using GIT. To see if you are impacted, simply do a git status inside ~/.oh-my-zsh/custom/plugins. If git list alot of files changed, then you have to bug. To fix it, you have 2 options. 1) Delete the ~/.oh-my-zsh folder and run this role again. 2) Use the command `git reset --hard HEAD` in each impacted git repo.

v1.9.1
======

Minor Changes
-------------

- nging - Manage SeLinux to allow connections and relay. Now Nginx can act as a reverse proxy!

v1.9.0
======

Minor Changes
-------------

- Change license to MIT
- nginx - New role to manage nginx
- user - Add user umask option

v1.8.2
======

Minor Changes
-------------

- tests - Remove our create playbook since it has been merge upstream

Bugfixes
--------

- firewalld - Fix a task that failed in check mode

v1.8.1
======

Minor Changes
-------------

- ohmyzsh - Updated the installer with latest ohmyzsh and plugins versions

Deprecated Features
-------------------

- ntp - Deprecating role. Will be remove in future release

Bugfixes
--------

- firewalld - Fix a task that failed in check mode

v1.8.0
======

Release Summary
---------------

This release drops support for RHEL7 in the firewalld role. This moves was decided because the molecule tests stop working on our RHEL8 VM that runs Podman. We prioritize moving to RHEL8 instead of spending time creating automated tests for an old version.
Unless someone step in to help, There is strong chances that all roles will soon drop support for RHEL7.'

Removed Features (previously deprecated)
----------------------------------------

- firewalld - Drop support for RHEL7

v1.7.3
======

Minor Changes
-------------

- awscli - Add support for global settings

v1.7.2
======

Bugfixes
--------

- awscli - Fix max_bandwidth default value to unlimited

v1.7.1
======

Bugfixes
--------

- awscli - Set a default region to prevent erros if left empty

v1.7.0
======

Major Changes
-------------

- s3cmd - Cut `s3cmd_options` object. Now every variable is prefixed by `s3cmd_`
- s3cmd - Cut dependency over a s3cmd_bucket object, now simply pass a `s3cmd_access_key` and `s3cmd_secret_key` to the role

Minor Changes
-------------

- awscli - Add new role to install and manage aws cli v2

Breaking Changes / Porting Guide
--------------------------------

- s3cmd - Due to breaking changes in 1.7.0, please do the following changes
- s3cmd - Remove from inventory any settings besides `access_key` and `secret_key` inside the `s3cmd_buckets` object.
- s3cmd - Remove one indentation of every variable contained in s3cmd_options and add the prefix `s3cmd_` to it.
- s3cmd - Remove parameters `s3cmd_options`
- s3cmd - Rename in your inventory `s3cmd_buckets` to `aws_credentials`

v1.6.1
======

Security Fixes
--------------

- s3cmd - Stop leaking secrets in ansible logs

Bugfixes
--------

- s3cmd - Fix host_base and log_target_prefix options

v1.6.0
======

Major Changes
-------------

- s3cmd - Every options are now configurable using `s3cmd_options` dictionary

Breaking Changes / Porting Guide
--------------------------------

- s3cmd - Cut `s3_` prefix from bucket options
- s3cmd - New mandatory option `s3cmd_options`. If you had a `s3cmd_buckets` dictionary in inventory. You can simply pass the right key to `s3cmd_options`.

Bugfixes
--------

- firewalld - Cut a task that installed iptables on any platform with a missleading title containing RHEL7.

v1.5.1
======

Bugfixes
--------

- ohmyzsh - Fix .zshrc never written

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
- Raise maximum Ansible version supported to 2.10+ since it's the version used by our molecule tests

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
