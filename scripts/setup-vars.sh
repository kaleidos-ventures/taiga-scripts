mkdir -p ~/.setup

if [ -e ~/.setup/data.sh ]; then
    source ~/.setup/data.sh
else
    echo -n "Scheme (default http): "
    read scheme
    echo -n "Hostname (default: localhost:8000): "
    read hostname

    if [ -z "$hostname" ]; then
        hostname="localhost:8000"
    fi

    if [ -z "$scheme" ]; then
        scheme="http"
    fi
fi

echo "Installing taigaio with user=$USER host=$hostname scheme=$scheme"
sleep 2
