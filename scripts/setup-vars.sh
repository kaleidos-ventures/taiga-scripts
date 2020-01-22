mkdir -p ~/.setup

if [ -e ~/.setup/data.sh ]; then
  # For unattended install get variables from cloud installer
    source ~/.setup/data.sh
else
  # Until https is implemented
  TAIGA_SCHEME="http"

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
  
fi

sleep 2
