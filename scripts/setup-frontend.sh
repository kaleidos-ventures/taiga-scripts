#!/bin/bash

FRONTEND_VERSION="stable"

pushd ~

cat > /tmp/main.json <<EOF
{
    "api": "/api/v1/",
    "debug": "true",
    "publicRegisterEnabled": true,
    "privacyPolicyUrl": null,
    "termsOfServiceUrl": null,
    "maxUploadFileSize": null
}
EOF


if [ ! -e ~/taiga-front ]; then
    # Initial clear
    git clone https://github.com/taigaio/taiga-front.git taiga-front
    pushd ~/taiga-front
    git checkout -f stable

    rm -rf ~/.npm
    npm cache clear

    gem-install-if-needed sass scss-lint
    npm-install-if-needed gulp bower

    mv /tmp/main.json conf/

    sudo rm -rf /home/$USER/tmp
    npm install

    sudo rm -rf /home/$USER/tmp

    bower install
    gulp deploy
    popd
else
    pushd ~/taiga-front
    git fetch
    git checkout -f stable
    git reset --hard origin/stable

    rm -rf ~/.npm
    npm cache clear

    npm install
    bower install
    gulp deploy
    popd
fi

popd



