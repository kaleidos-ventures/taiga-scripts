if [ ! -e ~/.setup/buildessential ]; then
    touch ~/.setup/buildessential

    apt-install-if-needed build-essential binutils-doc autoconf flex bison
    apt-install-if-needed libjpeg-dev libfreetype6-dev zlib1g-dev libzmq3-dev
    apt-install-if-needed libgdbm-dev libncurses5-dev automake libtool libffi-dev curl

    # Utils
    apt-install-if-needed git tmux postfix
fi
