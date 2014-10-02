#!/bin/bash

pushd ~

cat > /tmp/settings.py <<EOF
MEDIA_URL = "${scheme}://${hostname}/media/"
STATIC_URL = "${scheme}://${hostname}/static/"
ADMIN_MEDIA_PREFIX = "${scheme}://${hostname}/static/admin/"
EOF

if [ ! -e ~/.setup/taiga-back ]; then
    # Initial clean
    rm -rf taiga-back
    dropdb-if-needed taiga

    git clone https://github.com/taigaio/taiga-back.git taiga-back
    createdb-if-needed taiga

    rabbit-create-user-if-needed taiga taiga  # username, password
    rabbit-create-vhost-if-needed taiga
    rabbit-set-permissions taiga taiga ".*" ".*" ".*" # username, vhost, configure, read, write

    mkvirtualenv-if-needed taiga

    pushd ~/taiga-back

    # Settings
    cp settings/local.py.example settings/local.py
    cat /tmp/settings.py >> settings/local.py
    rm /tmp/settings.py

    workon taiga

    pip install -r requirements.txt
    python manage.py migrate --noinput
    python manage.py loaddata initial_user
    python manage.py loaddata initial_project_templates
    python manage.py loaddata initial_role
    python manage.py sample_data

    deactivate

    popd

    touch ~/.setup/taiga-back
fi

popd
