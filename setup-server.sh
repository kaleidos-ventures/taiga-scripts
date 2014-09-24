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
source ./scripts/setup-postgresql.sh
source ./scripts/setup-redis.sh
source ./scripts/setup-rabbitmq.sh
source ./scripts/setup-python.sh
source ./scripts/setup-utils.sh
source ./scripts/setup-nginx.sh
source ./scripts/setup-circus.sh

# Setup Server
source ./scripts/setup-repos.sh
source ./scripts/setup-server-front.sh
source ./scripts/setup-server-back.sh
