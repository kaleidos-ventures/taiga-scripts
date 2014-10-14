#!/bin/bash

pushd ~

cat > /tmp/settings.py <<EOF
from .common import *

MEDIA_URL = "${scheme}://${hostname}/media/"
STATIC_URL = "${scheme}://${hostname}/static/"
ADMIN_MEDIA_PREFIX = "${scheme}://${hostname}/static/admin/"
SITES["front"]["domain"] = "${hostname}"

DEBUG = True
TEMPLATE_DEBUG = True
PUBLIC_REGISTER_ENABLED = True

DEFAULT_FROM_EMAIL = "no-reply@example.com"
SERVER_EMAIL = DEFAULT_FROM_EMAIL

#EMAIL_BACKEND = "django.core.mail.backends.smtp.EmailBackend"
#EMAIL_USE_TLS = False
#EMAIL_HOST = "localhost"
#EMAIL_HOST_USER = ""
#EMAIL_HOST_PASSWORD = ""
#EMAIL_PORT = 25

REST_FRAMEWORK["DEFAULT_RENDERER_CLASSES"] = (
    "rest_framework.renderers.JSONRenderer",
)
EOF

if [ ! -e ~/.setup/taiga-back ]; then
    # Initial clean
    rm -rf taiga-back
    dropdb-if-needed taiga

    git clone https://github.com/taigaio/taiga-back.git taiga-back
    git checkout -f 1.1.0
    createdb-if-needed taiga

    # rabbit-create-user-if-needed taiga taiga  # username, password
    # rabbit-create-vhost-if-needed taiga
    # rabbit-set-permissions taiga taiga ".*" ".*" ".*" # username, vhost, configure, read, write
    mkvirtualenv-if-needed taiga

    pushd ~/taiga-back

    # Settings
    mv /tmp/settings.py settings/local.py
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
