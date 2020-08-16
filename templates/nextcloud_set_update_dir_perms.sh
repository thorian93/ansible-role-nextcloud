#!/bin/bash
# Sets permissions of the Nextcloud instance for updating

ncpath='{{nextcloud_web_dir}}'
htuser='{{ apache2_http_user }}'
htgroup='{{ apache2_http_user }}'

chown -R ${htuser}:${htgroup} ${ncpath}
