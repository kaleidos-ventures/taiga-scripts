#!/bin/bash

pushd ~

cat > /tmp/main.coffee <<EOF
config = {
    host: "${hostname}"
    scheme: "${scheme}"

    debug: true

    defaultLanguage: "en"
    languageOptions: {
        "en": "English"
    }

    publicRegisterEnabled: false
    privacyPolicyUrl: null
    termsOfServiceUrl: null
}

angular.module("taigaLocalConfig", []).value("localconfig", config)
EOF


if [ ! -e ~/.setup/taiga-front ]; then
    # Initial clear
    rm -rf taiga-front

    git clone https://github.com/taigaio/taiga-front.git taiga-front

    gem-install-if-needed sass scss-lint
    npm-install-if-needed gulp bower

    pushd ~/taiga-front
    mv /tmp/main.coffee app/config

    sudo rm -rf /home/$USER/tmp
    npm install
    bower install
    gulp deploy
    popd

    touch ~/.setup/taiga-front
fi

popd



