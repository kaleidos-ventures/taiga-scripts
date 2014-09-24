#!/bin/bash

pushd ~

if [ ! -e ~/taiga-front ]; then
    git clone https://github.com/taigaio/taiga-front.git taiga-front

    gem-install-if-needed sass
    npm-install-if-needed gulp bower
fi

popd

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

pushd ~/taiga-front
sudo rm -rf /home/#{username}/tmp
npm install
bower install
gulp deploy
popd


