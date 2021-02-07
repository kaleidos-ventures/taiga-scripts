# setup-certbot.sh
# install certbot and configure nginx

if [ ! -e ~/.setup/certbot ]; then

  touch ~/.setup/certbot

  if [ "$TAIGA_ENCRYPT" == "True" ]; then
    sudo apt-get install software-properties-common -y
    sudo add-apt-repository universe
    sudo add-apt-repository ppa:certbot/certbot -y
    sudo apt-get update
    sudo apt-get install certbot python-certbot-nginx -y
    sudo certbot --non-interactive --nginx -d $TAIGA_DOMAIN --agree-tos --email $TAIGA_SSL_EMAIL
  fi

fi
