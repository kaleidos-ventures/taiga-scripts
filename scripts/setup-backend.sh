#!/bin/bash

BACKEND_VERSION="stable"

pushd ~

cat > /tmp/settings.py <<EOF
from .common import *

MEDIA_URL = "/media/"
STATIC_URL = "/static/"

# This should change if you want generate urls in emails
# for external dns.
SITES["front"]["domain"] = "localhost:8000"

DEBUG = True
PUBLIC_REGISTER_ENABLED = True

DEFAULT_FROM_EMAIL = "no-reply@example.com"
SERVER_EMAIL = DEFAULT_FROM_EMAIL

#EMAIL_BACKEND = "django.core.mail.backends.smtp.EmailBackend"
#EMAIL_USE_TLS = False
#EMAIL_HOST = "localhost"
#EMAIL_HOST_USER = ""
#EMAIL_HOST_PASSWORD = ""
#EMAIL_PORT = 25

EOF

if [ ! -e ~/taiga-back ]; then
    createdb-if-needed taiga
    git clone https://github.com/taigaio/taiga-back.git taiga-back

    pushd ~/taiga-back
    git checkout -f stable

    # rabbit-create-user-if-needed taiga taiga  # username, password
    # rabbit-create-vhost-if-needed taiga
    # rabbit-set-permissions taiga taiga ".*" ".*" ".*" # username, vhost, configure, read, write
    mkvirtualenv-if-needed taiga

    # Settings
    mv /tmp/settings.py settings/local.py
    workon taiga

    pip install -r requirements.txt
    python manage.py migrate --noinput
    python manage.py compilemessages
    python manage.py collectstatic --noinput
    python manage.py loaddata initial_user
    python manage.py loaddata initial_project_templates
    python manage.py sample_data
    python manage.py rebuild_timeline --purge

    deactivate
    popd
else
    pushd ~/taiga-back
    git fetch
    git checkout -f stable
    git reset --hard origin/stable

    workon taiga
    pip install -r requirements.txt
    python manage.py migrate --noinput
    python manage.py compilemessages
    python manage.py collectstatic --noinput
    sudo service circus restart
    popd
fi

popd
