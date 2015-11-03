#!/bin/bash

source ./scripts/setup-common.sh

# Setup Taiga frontend
source ./scripts/setup-frontend.sh

# Post Setup Services
source ./scripts/setup-circus.sh
source ./scripts/setup-nginx.sh
