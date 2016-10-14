#!/bin/bash

apt-install-if-needed python3 python3-pip python-dev python3-dev python-pip virtualenvwrapper libxml2-dev libxslt1-dev
source /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh

function mkvirtualenv-if-needed {
    for envname in $@; do
        $(lsvirtualenv | grep -q "$envname") || mkvirtualenv "$envname" -p /usr/bin/python3.5
    done
}
