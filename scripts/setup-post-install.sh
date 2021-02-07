if [ ! -e ~/.setup/data.sh ]; then

  echo "---------------------------------------------------"
  echo "Installed taiga.io:"
  echo ""
  echo "Hostname: $TAIGA_HOSTNAME"
  echo "Import Sample Projects: $TAIGA_SAMPLE_DATA"
  echo "Public Registation Enabled: $TAIGA_PUBLIC_REGISTER_ENABLED"
  echo ""
  echo "URL: $TAIGA_SCHEME://$TAIGA_DOMAIN"
  echo "Username: admin"
  echo "Password: 123123"
  echo "(Please log in and change password)"
  echo ""
  echo "For more information please visit: http://taigaio.github.io/taiga-doc/dist/ "
  echo "---------------------------------------------------"

fi
