#!/bin/bash

# setup image processing support
apt-install-if-needed libjpeg-dev libfreetype6-dev zlib1g-dev

createdb-if-needed taiga
rabbit-create-user-if-needed taiga taiga  # username, password
rabbit-create-vhost-if-needed taiga
rabbit-set-permissions taiga taiga ".*" ".*" ".*" # username, vhost, configure, read, write

create-pyenv "env"

cd ~/taiga-back
source ~/env/bin/activate
pip install -r requirements.txt
