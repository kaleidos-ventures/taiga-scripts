#!/bin/bash

apt-install-if-needed python3 python3-pip python-virtualenv python-dev python3-dev python-pip

function create-pyenv {
    pushd ~

    for envname in $@; do
        if [ ! -e ~/$envname ]; then
            virtualenv env -p python3
        fi
    done

    popd
}
