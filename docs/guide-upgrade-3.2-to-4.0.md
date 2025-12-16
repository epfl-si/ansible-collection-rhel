# Upgrade guide from 3.2 to 4.0

## Role SSHD

1. Compare your settings with the defaults:

    ```sh
    diff <(sshd -T -f /etc/ssh/sshd_config.rpmnew) <(sshd -T -f /etc/ssh/sshd_config)
    ```

1. Report the settings in green in a the variable: `sshd_configs`.

    ```yaml
    sshd_configs:
      - name: 20-my-settings.conf
        content: |
          syslogfacility AUTHPRIV
          loglevel VERBOSE
          passwordauthentication no
    ```

1. Check for conflict with existing drop-in files. The options precedence is: first declared wins. For instance for RHEL9 you'll find this file:
  
    ```sh
    cat /etc/ssh/ssh_config.d/05-redhat.conf
    ```

1. Restore the default SSHD configuration:
  
    ```sh
    sudo -i
    mv /etc/ssh/sshd_config /etc/ssh/sshd_config.backup-ansible-2025-12-16
    mv /etc/ssh/sshd_config.rpmnew /etc/ssh/sshd_config
    systemctl restart sshd.service
    ```
