if [ ! -e ~/.setup/buildessential ]; then
    touch ~/.setup/buildessential

    apt-install-if-needed build-essential binutils-doc autoconf flex bison libjpeg-dev libfreetype6-dev zlib1g-dev libzmq3-dev libgdbm-dev libncurses5-dev automake libtool libffi-dev curl gettext cairo

    # Utils
    apt-install-if-needed git tmux
fi
