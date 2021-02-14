#!/bin/bash
# Sets permissions of the Nextcloud instance for updating

ncpath='{{ nextcloud_web_dir }}'
ncdatapath='{{ nextcloud_data_dir }}'
htuser='{{ apache2_http_user }}'
htgroup='{{ apache2_http_user }}'

chown -R ${htuser}:${htgroup} ${ncpath}
chown -R ${htuser}:${htgroup} ${ncdatapath}
