#!/bin/bash

if [[ $EUID -eq 0 ]]; then
  echo "taiga-scripts doesn't works properly if it used with root user." 1>&2
  exit 1
fi

source ./setup-devel.sh

# Post Setup Services
source ./scripts/setup-circus.sh
source ./scripts/setup-nginx.sh
