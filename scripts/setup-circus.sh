#!/bin/bash

pip3 install circus --no-warn-script-location

cat > /tmp/taiga-circus.ini <<EOF
[watcher:taiga]
working_dir = /home/$USER/taiga-back
cmd = gunicorn
args = -w 3 -t 60 --pythonpath=. -b 127.0.0.1:8001 taiga.wsgi
uid = $USER
numprocesses = 1
autostart = true
send_hup = true
stdout_stream.class = FileStream
stdout_stream.filename = /home/$USER/logs/gunicorn.stdout.log
stdout_stream.max_bytes = 10485760
stdout_stream.backup_count = 4
stderr_stream.class = FileStream
stderr_stream.filename = /home/$USER/logs/gunicorn.stderr.log
stderr_stream.max_bytes = 10485760
stderr_stream.backup_count = 4

[env:taiga]
PATH = /home/$USER/.virtualenvs/taiga/bin:$PATH
TERM=rxvt-256color
SHELL=/bin/bash
USER=taiga
LANG=en_US.UTF-8
HOME=/home/$USER
PYTHONPATH=/home/$USER/.local/lib/python3.8/site-packages
EOF

cat > /tmp/taiga-circus.service <<EOF
[Unit]
Description=Circus process manager
After=syslog.target network.target nss-lookup.target

[Service]
User=$USER
Type=simple
ExecReload=/home/$USER/.local/bin/circusctl reload
ExecStart=/home/$USER/.local/bin/circusd /home/$USER/.local/lib/python3.8/site-packages/circus/conf.d/taiga.ini
Restart=always
RestartSec=5

[Install]
WantedBy=default.target
EOF

mkdir -p ~/.setup

if [ ! -e ~/.setup/circus ]; then
    mkdir -p $HOME/.local/lib/python3.8/site-packages/circus/conf.d
    sudo mv /tmp/taiga-circus.ini $HOME/.local/lib/python3.8/site-packages/circus/conf.d/taiga.ini
    sudo mv /tmp/taiga-circus.service /etc/systemd/system/circusd.service

    sudo systemctl --system daemon-reload
    sudo service circusd restart
    sudo systemctl enable circusd
    
    touch ~/.setup/circus
fi
