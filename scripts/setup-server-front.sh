#!/bin/bash

gem-install-if-needed sass
npm-install-if-needed gulp bower

cat > /home/${username}/taiga-front/app/config/main.coffee <<EOF
config = {
    host: "${hostname}"
    scheme: "${scheme}"

    debug: true

    defaultLanguage: "en"
    languageOptions: {
        "en": "English"
    }

    publicRegisterEnabled: true
    privacyPolicyUrl: null
    termsOfServiceUrl: null
}

angular.module("taigaLocalConfig", []).value("localconfig", config)
EOF

pushd ~/taiga-front
npm install
bower install
gulp deploy
popd
