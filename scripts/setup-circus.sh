#!/bin/bash

cat > /tmp/circus.ini <<EOF
[circus]
check_delay = 5
endpoint = tcp://127.0.0.1:5555
pubsub_endpoint = tcp://127.0.0.1:5556
statsd = true

[watcher:taiga]
working_dir = /home/$USER/taiga-back
cmd = gunicorn -w 3 -t 60 --pythonpath=. taiga.wsgi
uid = $USER
numprocesses = 1
autostart = true
send_hup = true
stdout_stream.class = FileStream
stdout_stream.filename = /home/$USER/logs/gunicorn.log
stdout_stream.refresh_time = 0.3
stdout_stream.max_bytes = 1073741824
stdout_stream.backup_count = 2

[env:taiga]
PATH = \$PATH:/home/$USER/.virtualenvs/taiga/bin
EOF

cat > /tmp/rc.local <<EOF
#!/bin/sh -e
. /etc/rc.local.circusd
exit 0
EOF

cat > /tmp/rc.local.circusd <<EOF
/usr/local/bin/circusd --daemon /home/$USER/conf/circus.ini
EOF

if [ ! -e ~/.setup/circus ]; then
    sudo pip2 install circus

    mv /tmp/circus.ini /home/$USER/conf/circus.ini
    sudo mv /tmp/rc.local /etc/rc.local
    sudo mv /tmp/rc.local.circusd /etc/rc.local.circusd
    sudo chmod +x /etc/rc.local
    sudo chmod +x /etc/rc.local.circusd

    sudo /usr/local/bin/circusd --daemon /home/$USER/conf/circus.ini

    touch ~/.setup/circus
fi
