#!/bin/bash

cat > /tmp/circus.ini <<EOF
[circus]
check_delay = 5
endpoint = tcp://127.0.0.1:5555
pubsub_endpoint = tcp://127.0.0.1:5556
statsd = true

[watcher:taiga]
working_dir = /home/${username}/taiga-back
cmd = gunicorn -w 3 -t 60 --pythonpath=. taiga.wsgi
uid = ${username}
numprocesses = 1
autostart = true
send_hup = true
stdout_stream.class = FileStream
stdout_stream.filename = /home/${username}/logs/gunicorn.log
stdout_stream.refresh_time = 0.3
stdout_stream.max_bytes = 1073741824
stdout_stream.backup_count = 2

[env:taiga]
PATH = $PATH:/home/${username}/env/bin
EOF

cat > /tmp/rc.local <<EOF
#!/bin/sh -e
. /etc/rc.local.circusd
exit 0
EOF

cat > /tmp/rc.local.circusd <<EOF
/usr/local/bin/circusd --daemon /home/${username}/conf/circus.ini
EOF

if [ ! -e /etc/rc.local.circusd ]; then
    sudo pip2 install circus

    mv /tmp/circus.ini /home/${username}/conf/circus.ini
    sudo mv /tmp/rc.local /etc/rc.local
    sudo mv /tmp/rc.local.circusd /etc/rc.local.circusd
    sudo chmod +x /etc/rc.local
    sudo chmod +x /etc/rc.local.circusd

    sudo /usr/local/bin/circusd --daemon /home/${username}/conf/circus.ini
fi
