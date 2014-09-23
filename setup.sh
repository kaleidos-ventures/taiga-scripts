#!/bin/bash

rootdir=`pwd`
username="$USER"

# Nginx configuration
scheme="https"
hostname="taiga.projects.kaleidos.net"

pushd ~
mkdir -p logs
mkdir -p conf
popd

# Bootstrap
source ./scripts/common.sh

# Install (services and libraries)
source ./scripts/install-postgresql.sh
source ./scripts/install-redis.sh
source ./scripts/install-rabbitmq.sh
source ./scripts/install-python.sh
source ./scripts/install-utils.sh

# Setup
source ./scripts/setup-nginx.sh
source ./scripts/setup-circus.sh
source ./scripts/setup-repos.sh
source ./scripts/setup-front.sh
source ./scripts/setup-back.sh
