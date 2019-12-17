#!/bin/bash -xv
echo "<h1>This page served by "$HOSTNAME" server</h1>" | sudo tee /var/www/html/index.html
curl -L https://toolbelt.treasuredata.com/sh/install-debian-buster-td-agent3.sh | sh
echo -e "<source>\n   @type tail\n   path /var/log/nginx/access.log\n   pos_file /var/log/td-agent/nginx.access_log.pos\n   tag s3.nginx.access #fluentd tag!\n   <parse>\n     @type nginx\n   </parse>\n   tag s3.nginx.access\n</source>\n \n<match s3.*.*>\n   @type s3\n \n   s3_bucket opschl-web-db-ha-nginx-accesslog\n   path logs/\n \n   <buffer>\n     @type file\n     path /var/log/td-agent/s3\n     timekey 3600  # 1 hour\n     timekey_wait 10m\n     chunk_limit_size 256m\n   </buffer>\n \n   time_slice_format %Y%m%d%H\n</match>\n" | sudo tee /etc/td-agent/td-agent.conf
usermod -a -G adm td-agent
sudo systemctl enable td-agent.service
sudo systemctl start td-agent.service
