Role Nginx
==============

A role to manage nginx options and restart the service.

Will installed the default version of Nginx available on RHEL. At the moment, it's 1.14 on RHEL.


Requirements
------------

None


Role Variables
--------------

The role parameters are in meta/argument_specs.yml or use the command `ansible-doc --type role ningx` to read them.

Dependencies
------------

None

Example Playbook
----------------

    - hosts: servers
      roles:
        - epfl_si.rhel.nginx
          nginx_http: |
            # Logging
            access_log  /var/log/nginx/access.log;
            error_log   /var/log/nginx/error.log warn;
          nginx_servers:
            - |
              listen 80;
              server_name test.example.com;
            - |
              listen 443;
              server_name test.example.com;


License
-------

MIT

Author Information
------------------

laurent.indermuehle@epfl.ch
