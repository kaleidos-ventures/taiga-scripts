#!/bin/bash

pushd ~

cat > /tmp/main.json <<EOF
{
    "api": "http://${hostname}/api/v1/",
    "eventsUrl": "ws://${hostname}/events",
    "debug": "true",
    "publicRegisterEnabled": true,
    "privacyPolicyUrl": null,
    "termsOfServiceUrl": null
}
EOF


if [ ! -e ~/.setup/taiga-front ]; then
    # Initial clear
    rm -rf taiga-front

    git clone https://github.com/taigaio/taiga-front.git taiga-front
    pushd ~/taiga-front
    git checkout stable 

    gem-install-if-needed sass scss-lint
    npm-install-if-needed gulp bower

    mv /tmp/main.json conf/

    sudo rm -rf /home/$USER/tmp
    npm install

    sudo rm -rf /home/$USER/tmp

    bower install
    gulp deploy
    popd

    touch ~/.setup/taiga-front
fi

popd



