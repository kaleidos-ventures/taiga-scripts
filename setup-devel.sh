#!/bin/bash

source ./scripts/setup-common.sh

# Setup tools for building the frontend
source ./scripts/setup-ruby.sh
source ./scripts/setup-node.sh

# Setup Taiga frontend
source ./scripts/setup-frontend-dev.sh
