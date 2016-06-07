#!/bin/bash

apt-install-if-needed circus

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
PYTHONPATH=/home/$USER/.local/lib/python3.4/site-packages
EOF

if [ ! -e ~/.setup/circus ]; then
    sudo mv /tmp/taiga-circus.ini /etc/circus/conf.d/taiga.ini

    sudo service circusd restart
    touch ~/.setup/circus
fi
