#!/bin/bash


pushd ~
mkdir -p logs
mkdir -p conf
popd

# System information and verification
source ./scripts/setup-os-release.sh

# Bootstrap
source ./scripts/setup-vars.sh
source ./scripts/setup-hostname.sh
source ./scripts/setup-config.sh
source ./scripts/setup-apt.sh

# Setup and install services dependencies
source ./scripts/setup-postgresql.sh
#source ./scripts/setup-redis.sh
#source ./scripts/setup-rabbitmq.sh

# Setup and install python related dependencies
source ./scripts/setup-buildessential.sh
source ./scripts/setup-python.sh

# Setup Taiga
source ./scripts/setup-frontend.sh
source ./scripts/setup-backend.sh
