#!/bin/bash

if [ -z $(which git) ]; then
    apt-install git
fi

if [ ! -e ~/taiga-back ]; then
    pushd ~
    git clone https://github.com/taigaio/taiga-back.git taiga-back
    popd
fi

if [ ! -e ~/taiga-front ]; then
    pushd ~
    git clone https://github.com/taigaio/taiga-front.git taiga-front
    popd
fi
