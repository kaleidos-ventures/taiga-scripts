#!/bin/bash

cat > /tmp/nginx.conf <<EOF
user www-data;
worker_processes 2;
pid /var/run/nginx.pid;

events {
    worker_connections 1024;
}

http {
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 15;
    types_hash_max_size 2048;

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;

    gzip on;
    gzip_disable "msie6";

    gzip_vary on;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_buffers 16 8k;
    gzip_http_version 1.1;
    gzip_types text/plain text/css application/json application/x-javascript
                    text/xml application/xml application/xml+rss text/javascript;

    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;
}
EOF

cat > /tmp/taiga.conf <<EOF
server {
    listen 80 default_server;
    server_name _;

    client_max_body_size 50M;
    charset utf-8;

    access_log /home/${username}/logs/nginx.access.log;
    error_log /home/${username}/logs/nginx.error.log;

    location / {
        root /home/${username}/taiga-front/dist/;
        try_files \$uri \$uri/ /index.html;
    }

    location /api {
        proxy_set_header Host \$http_host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Scheme \$scheme;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_pass http://127.0.0.1:8000/api;
        proxy_redirect off;
    }

    location /static {
        alias /home/${username}/taiga-back/static;
    }

    location /media {
        alias /home/${username}/taiga-back/media;
    }
}
EOF

apt-install-if-needed nginx-full

if [ ! -e /etc/nginx/.taiga ]; then
    sudo touch /etc/nginx/.taiga

    sudo mv /tmp/nginx.conf /etc/nginx/nginx.conf
    sudo mv /tmp/taiga.conf /etc/nginx/sites-available/default
    sudo /etc/init.d/nginx restart
fi
