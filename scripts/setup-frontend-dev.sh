#!/bin/bash

FRONTEND_VERSION="stable"

pushd ~

cat > /tmp/conf.json <<EOF
{
    "api": "http://127.0.0.1:8000/api/v1/",
    "eventsUrl": null,
    "debug": "true",
    "publicRegisterEnabled": true,
    "feedbackEnabled": false,
    "privacyPolicyUrl": null,
    "termsOfServiceUrl": null,
    "maxUploadFileSize": null,
    "gitHubClientId": null,
    "contribPlugins": []
}
EOF


if [ ! -e ~/taiga-front ]; then
    # Initial clear
    git clone https://github.com/taigaio/taiga-front.git taiga-front
    pushd ~/taiga-front
    git checkout -f $FRONTEND_VERSION
    mkdir -p dist/js
    mv /tmp/conf.json dist/js/
    popd
else
    pushd ~/taiga-front
    git fetch
    git checkout -f $FRONTEND_VERSION
    git reset --hard origin/stable
    popd
fi

pushd ~/taiga-front
npm install
bower install --config.interactive=false
popd

popd
