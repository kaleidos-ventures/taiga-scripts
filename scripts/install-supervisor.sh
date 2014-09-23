# supervisor.sh

apt-install-if-needed supervisor

function supervisor-restart {
    sudo /etc/init.d/supervisor restart
}
