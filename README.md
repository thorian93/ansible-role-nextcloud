# Ansible Role: Nextcloud

This role installs Nextcloud on Debian/Ubuntu, RHEL/CentOS and Fedora servers.

[![Ansible Role: Nextcloud](https://img.shields.io/ansible/role/55140?style=flat-square)](https://galaxy.ansible.com/thorian93/nextcloud)
[![Ansible Role: Nextcloud](https://img.shields.io/ansible/quality/55140?style=flat-square)](https://galaxy.ansible.com/thorian93/nextcloud)
[![Ansible Role: Nextcloud](https://img.shields.io/ansible/role/d/55140?style=flat-square)](https://galaxy.ansible.com/thorian93/nextcloud)

## Known issues

- Installation on Debian works generally but automatic setup of Nextcloud is currently not possible. You need to do this manually as of now.

## Requirements

No special requirements; note that this role requires root access, so either run it in a playbook with a global `become: yes`, or invoke the role in your playbook like:

    - hosts: foobar
      roles:
        - role: thorian93.nextcloud
          become: yes

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    nextcloud_version: "20.0.5"

Define the Nextcloud version you want to install.

    nextcloud_create_self_signed_cert: true
    nextcloud_self_signed_cert_subj: "/C=DE/ST=FOO/L=BAR/O=Org/CN={{ nextcloud_external_url }}"
    nextcloud_self_signed_certificate_key: "/etc/{{ apache2_http_name }}/ssl/nextcloud.key"
    nextcloud_self_signed_certificate: "/etc/{{ apache2_http_name }}/ssl/nextcloud.crt"

Configure self signed certificates to your liking.

    nextcloud_custom_cert: false
    nextcloud_custom_cert_file: /etc/{{ apache2_http_name }}/ssl/nextcloud.crt
    nextcloud_custom_cert_key: /etc/{{ apache2_http_name }}/ssl/nextcloud.key

If you want to use your own certificate you can define that here.

    nextcloud_certificate_key: "{{ certbot_cert_path }}/privkey.pem"
    nextcloud_certificate: "{{ certbot_cert_path }}/cert.pem"
    nextcloud_certificate_chain: "{{ certbot_cert_path }}/fullchain.pem"

If `nextcloud_create_self_signed_cert` and `nextcloud_custom_cert` are set to false, my [ansible_role_certbot](https://galaxy.ansible.com/thorian93/certbot) will be used to acquire certificates.

    nextcloud_db_system: "mysql"
    nextcloud_db_host: "127.0.0.1"
    nextcloud_db_name: "nextcloud"

Configure the database for Nextcloud. Currently available is only MySQL/MariaDB.

    nextcloud_enable_opt_prerequisites: true

This installs some optional software which is useful for Nextcloud.

    nextcloud_turn_enable: 'false'
    nextcloud_turn_ip: " {{ ansible_default_ipv4.address }}"
    nextcloud_turn_port: 3478
    nextcloud_turn_realm: "{{ nextcloud_external_url }}"
    # Set this in your inventory. By default this role will generate a new secret on every run until this variable is set.
    # nextcloud_turn_secret:

Enable and configure setup of a TURN server for Nextcloud Talk on your server. For further information see the [Nextcloud documentation](https://nextcloud-talk.readthedocs.io/en/latest/TURN). Keep an eye on the `nextcloud_turn_secret` variable!

    nextcloud_backup: false
    nextcloud_backup_path: "/tmp"

Configure Backups for Nextcloud.

    nextcloud_web_dir: "/var/www/nextcloud"
    nextcloud_data_dir: "/var/www/nextcloud/data"

Define directories for Nextcloud.  
**It is recommended to put the data directory outside of the web root.**  
*The web root is configurable but currently only supports residing in `/var/www`. Putting the application outside of `/var/www` won't work currently! This does however not affect the data directory.*

    nextcloud_php_options:
      - line: "post_max_size = 4G"
        regexp: "^post_max_size ="
      - line: "upload_max_filesize = 4G"
        regexp: "^upload_max_filesize ="
      - line: "open_basedir ='{{ nextcloud_web_dir }}:{{ nextcloud_data_dir }}:/tmp:/dev/urandom'"
        regexp: "^open_basedir ="

Define PHP options for Nextcloud. The defaults given here are necessary for Nextcloud to work properly.

    nextcloud_enabled_apps:
      - files

List the apps which should be enabled.

## Dependencies

  - [thorian93.apache2](https://galaxy.ansible.com/thorian93/apache2)
  - [thorian93.php](https://galaxy.ansible.com/thorian93/nextcloud)
  - [thorian93.certbot](https://galaxy.ansible.com/thorian93/certbot) - when no custom or self signed certificate is used
  - [thorian93.mysql](https://galaxy.ansible.com/thorian93/mysql)

## OS Compatibility

This role ensures that it is not used against unsupported or untested operating systems by checking, if the right distribution name and major version number are present in a dedicated variable named like `<role-name>_stable_os`. You can find the variable in the role's default variable file at `defaults/main.yml`:

    role_stable_os:
      - Debian 10
      - Ubuntu 18
      - CentOS 7
      - Fedora 30

If the combination of distribution and major version number do not match the target system, the role will fail. To allow the role to work add the distribution name and major version name to that variable and you are good to go. But please test the new combination first!

Kudos to [HarryHarcourt](https://github.com/HarryHarcourt) for this idea!

## Example Playbook

    ---
    - name: "Run role."
      hosts: all
      become: yes
      roles:
        - ansible-role-nextcloud

## Contributing

Please feel free to open issues if you find any bugs, problems or if you see room for improvement. Also feel free to contact me anytime if you want to ask or discuss something.

## Disclaimer

This role is provided AS IS and I can and will not guarantee that the role works as intended, nor can I be accountable for any damage or misconfiguration done by this role. Study the role thoroughly before using it.

## License

MIT

## Author Information

This role was created in 2020 by [Thorian93](http://thorian93.de/).
