# redis.sh

mkdir -p ~/.setup

if [ ! -e ~/.setup/redis ]; then
    touch ~/.setup/redis

    apt-install-if-needed redis-server
fi
