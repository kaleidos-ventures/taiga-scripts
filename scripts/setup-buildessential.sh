if [ ! -e ~/.setup/buildessential ]; then
    touch ~/.setup/buildessential

    if [ "$VERSION_ID" = "18.04" ]; then
    apt-install-if-needed automake wget curl gettext circus \
    build-essential libgdbm-dev  binutils-doc autoconf flex gunicorn \
    bison libjpeg-dev libzmq3-dev libfreetype6-dev zlib1g-dev \
    libncurses5-dev libtool libxslt1-dev libxml2-dev libffi-dev \
    libssl-dev circus

    # Utils
    apt-install-if-needed git pwgen tmux

  elif [ "$VERSION_ID" = "16.04" ]; then
    apt-install-if-needed build-essential binutils-doc autoconf \
    flex bison libjpeg-dev libfreetype6-dev zlib1g-dev libzmq3-dev \
    libgdbm-dev libncurses5-dev automake libtool libffi-dev curl \
    gettext cairo

    # Utils
    apt-install-if-needed git tmux
  fi
fi
