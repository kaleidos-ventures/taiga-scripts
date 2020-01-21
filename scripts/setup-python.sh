#!/bin/bash

if [ "$VERSION_ID" = "18.04" ]; then
  # Define python version for virtualenv
  PYTHON_VERSION="python3.6"
  apt-install-if-needed python3 python3-pip python3-dev python3-pip virtualenvwrapper
elif [ "$VERSION_ID" = "16.04" ]; then
  PYTHON_VERSION="python3.5"
  apt-install-if-needed python3 python3-pip python-dev python3-dev python-pip virtualenvwrapper libxml2-dev libxslt1-dev
fi
source /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh

function mkvirtualenv-if-needed {
    for envname in $@; do
        $(lsvirtualenv | grep -q "$envname") || mkvirtualenv "$envname" -p /usr/bin/$PYTHON_VERSION
    done
}
