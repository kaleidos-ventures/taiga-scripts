#!/bin/bash

cat > /home/${username}/taiga-front/app/config/main.coffee <<EOF
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

pushd ~

if [ ! -e ~/taiga-front ]; then
    git clone https://github.com/taigaio/taiga-front.git taiga-front

    gem-install-if-needed sass
    npm-install-if-needed gulp bower

    sudo rm -rf /home/#{username}/tmp

    pushd ~/taiga-front
    npm install
    bower install
    gulp deploy
    popd
fi

popd

