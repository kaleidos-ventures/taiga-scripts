# setup-hostname.sh
# set up hostname and domain name in hosts file

if [ ! -e ~/.setup/hostname ]; then

  touch ~/.setup/hostname

  if [ "$TAIGA_HOSTNAME" != "localhost" ] && [ "$TAIGA_HOSTNAME" != $(hostname) ]; then
    sudo hostnamectl set-hostname $TAIGA_HOSTNAME
    echo "127.0.0.1   $TAIGA_HOSTNAME" | sudo tee -a /etc/hosts
  fi

  if [ "$TAIGA_DOMAIN" != "$IP_ADDRESS" ] ; then
    echo "$IP_ADDRESS   $TAIGA_DOMAIN" | sudo tee -a /etc/hosts
  fi

fi
