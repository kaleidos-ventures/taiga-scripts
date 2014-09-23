#!/bin/bash

apt-install-if-needed nodejs npm

nodejspath=$(which nodejs)
sudo ln -sf $nodejspath ${nodejspath::-2}

function npm-install {
    for pkg in $@; do
        echo -e "${cyan}[NPM] Installing package $pkg..."
        sudo npm install -g $pkg
    done
}

function npm-install-if-needed {
    for pkg in $@; do
        if npm-package-not-installed $pkg; then
            npm-install $pkg
        fi
    done
}


function npm-package-not-installed {
    test -z $(npm list -g 2> /dev/null | grep "$1@" | cut -d'@' -f2)
}
