mkdir -p ~/.setup

if [ -e ~/.setup/data.sh ]; then
  # For unattended install get variables from cloud installer
    source ~/.setup/data.sh
else

  # Determine active network interface and active IP Address, if not connected, use hostname
  NET_INTERFACE=$(ip addr show | awk '/inet.*brd/{print $NF; exit}')
  if [[ $NET_INTERFACE = "" ]]; then
    IP_ADDRESS=$(hostname)
  else
    IP_ADDRESS=${TAIGA_DOMAIN:-$(/sbin/ifconfig $NET_INTERFACE | awk '/inet / { print $2 }' | sed 's/addr://')}
  fi

  read -p "Host name (default: $(hostname)):" TAIGA_HOSTNAME
  TAIGA_HOSTNAME=${TAIGA_HOSTNAME:-$(hostname)}

  read -p "Fully qualified domain name or IP address (default: $IP_ADDRESS): " TAIGA_DOMAIN
  TAIGA_DOMAIN=${TAIGA_DOMAIN:-$IP_ADDRESS}

  if [ "$TAIGA_DOMAIN" != "$IP_ADDRESS" ] ; then
    read -p "Use encryption (from letsencrypt.org + certbot) for domain '$TAIGA_DOMAIN' - requires email next step (y/N):" TAIGA_ENCRYPT
    case $TAIGA_ENCRYPT in
      [Yy]* ) TAIGA_ENCRYPT="True";;
      * ) TAIGA_ENCRYPT="False";;
    esac

    if [ "$TAIGA_ENCRYPT" == "True" ] ; then
      TAIGA_SCHEME="https"
      while [[ $TAIGA_SSL_EMAIL == "" ]]; do
        read -p "Email to use for certificate notifications (required, cartificate will fail if invalid): " TAIGA_SSL_EMAIL
      done
    fi

  fi

  read -p "Import Sample Projects (Y/n):" TAIGA_SAMPLE_DATA
  case $TAIGA_SAMPLE_DATA in
    [Nn]* ) TAIGA_SAMPLE_DATA="False";;
    * ) TAIGA_SAMPLE_DATA="True";;
  esac

  read -p "Public Registation Enabled: (Y/n):" TAIGA_PUBLIC_REGISTER_ENABLED
  case $TAIGA_PUBLIC_REGISTER_ENABLED in
    [Nn]* ) TAIGA_PUBLIC_REGISTER_ENABLED="False";;
    * ) TAIGA_PUBLIC_REGISTER_ENABLED="True";;
  esac

  TAIGA_SCHEME=${TAIGA_SCHEME:-"http"}

fi

sleep 2
