#!/bin/bash

rootdir=`pwd`
username="$USER"

echo -n "Scheme (default http): "
read scheme
echo -n "Hostname (default: localhost:8000): "
read hostname

if [ -z "$hostname" ]; then
    hostname="localhost:8000"
fi

if [ -z "$scheme" ]; then
    scheme="http"
fi

pushd ~
mkdir -p logs
mkdir -p conf
popd

# Bootstrap
source ./scripts/setup-config.sh
source ./scripts/setup-apt.sh

# Setup and install services dependencies
source ./scripts/setup-postgresql.sh
source ./scripts/setup-redis.sh
source ./scripts/setup-rabbitmq.sh

# Setup and install python related dependencies
source ./scripts/setup-buildessential.sh
source ./scripts/setup-ruby.sh
source ./scripts/setup-nodejs.sh
source ./scripts/setup-python.sh

# Setup Taiga
source ./scripts/setup-frontend.sh
source ./scripts/setup-backend.sh

# Post Setup Services
source ./scripts/setup-circus.sh
source ./scripts/setup-nginx.sh
