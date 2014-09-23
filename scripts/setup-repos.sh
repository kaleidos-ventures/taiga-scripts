#!/bin/bash

if [ -z $(which git) ]; then
    apt-install git
fi

if [ ! -e ~/taiga-back ]; then
    git clone https://github.com/taigaio/taiga-back.git taiga-back
fi

if [ ! -e ~/taiga-front ]; then
    git clone https://github.com/taigaio/taiga-front.git taiga-front
fi
