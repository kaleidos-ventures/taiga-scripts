#!/bin/bash

source /etc/os-release
if [ "$VERSION_ID" != "18.04" ] && [ "$VERSION_ID" != "16.04" ]; then
  echo "This script is not compatible with your current OS: $PRETTY_NAME"
  echo "Please try to install on Ubuntu-18.04 LTS or Ubuntu-16.04 LTS"
  exit 1
else
  echo "Installing taigaio on $PRETTY_NAME"
fi
sleep 3
