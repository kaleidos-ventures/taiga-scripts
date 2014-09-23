#!/bin/bash
apt-install-if-needed python3

cd ~

function create-pyenv {
    for envname in $@; do
        rm -rf $envname
        pyvenv-3.4 $envname
    done
}
