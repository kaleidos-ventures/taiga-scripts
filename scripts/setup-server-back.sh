#!/bin/bash

dropdb-if-needed taiga
createdb-if-needed taiga

rabbit-create-user-if-needed taiga taiga  # username, password
rabbit-create-vhost-if-needed taiga
rabbit-set-permissions taiga taiga ".*" ".*" ".*" # username, vhost, configure, read, write

create-pyenv-if-needed "env"

pushd ~/taiga-back
source ~/env/bin/activate
pip install -r requirements.txt
python manage.py migrate --noinput
python manage.py loaddata initial_user
python manage.py loaddata initial_project_templates
python manage.py loaddata initial_role
popd
