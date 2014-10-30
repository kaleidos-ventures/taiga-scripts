#!/bin/bash

cat > /tmp/circus.ini <<EOF
[circus]
check_delay = 5
endpoint = tcp://127.0.0.1:5555
pubsub_endpoint = tcp://127.0.0.1:5556
statsd = true

[watcher:taiga]
working_dir = /home/$USER/taiga-back
cmd = gunicorn
args = -w 3 -t 60 --pythonpath=. -b 0.0.0.0:8001 taiga.wsgi
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
PATH = $PATH:/home/$USER/.virtualenvs/taiga/bin
TERM=rxvt-256color
SHELL=/bin/bash
USER=taiga
LANG=en_US.UTF-8
HOME=/home/$USER
PYTHONPATH=/home/$USER/.local/lib/python3.4/site-packages
EOF

cat > /tmp/circus.conf <<EOF
start on filesystem and net-device-up IFACE=lo
stop on runlevel [016]

respawn
exec /usr/local/bin/circusd /home/$USER/conf/circus.ini
EOF

if [ ! -e ~/.setup/circus ]; then
    sudo pip2 install circus

    mv /tmp/circus.ini /home/$USER/conf/circus.ini
    sudo mv /tmp/circus.conf /etc/init/circus.conf

    sudo service circus start
    touch ~/.setup/circus
fi
