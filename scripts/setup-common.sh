#!/bin/bash

if [[ $EUID -eq 0 ]]; then
  echo "taiga-scripts doesn't works properly if it used with root user." 1>&2
  exit 1
fi

pushd ~
mkdir -p logs
mkdir -p conf
popd

# Bootstrap
# source ./scripts/setup-vars.sh
source ./scripts/setup-config.sh
source ./scripts/setup-apt.sh

# Setup and install services dependencies
source ./scripts/setup-postgresql.sh
#source ./scripts/setup-redis.sh
#source ./scripts/setup-rabbitmq.sh

# Setup and install Python related dependencies
source ./scripts/setup-buildessential.sh
source ./scripts/setup-python.sh

# Setup Taiga backend
source ./scripts/setup-backend.sh
