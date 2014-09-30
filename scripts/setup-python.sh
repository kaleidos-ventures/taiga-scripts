#!/bin/bash

apt-install-if-needed python3 python3-pip python-dev python3-dev python-pip
pip3 install --user virtualenv virtualenvwrapper

cat > ~/.virtualenvwrapper-conf.sh <<EOF
export PYTHONPATH="/home/$USER/.local/lib/python3.4/site-packages"
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python3.4"
export PATH=~/.local/bin:$PATH
source ~/.local/bin/virtualenvwrapper.sh
EOF

cat >> ~/.bash_profile <<EOF
source ~/.virtualenvwrapper-conf.sh
EOF

source ~/.virtualenvwrapper-conf.sh

function mkvirtualenv-if-needed {
    for envname in $@; do
        $(lsvirtualenv | grep -q "$envname") || mkvirtualenv "$envname" -p /usr/bin/python3.4
    done
}
