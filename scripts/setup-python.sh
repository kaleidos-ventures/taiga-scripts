#!/bin/bash

apt-install-if-needed python3 python3-pip python-dev python3-dev python-pip
pip3 install --user virtualenv virtualenvwrapper

cat > ~/.virtualenvwrapper-conf.sh <<EOF
export PYTHONPATH="/home/${username}/.local/lib/python3.4/site-packages"
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python3.4"
export PATH=~/.local/bin:$PATH
source ~/.local/bin/virtualenvwrapper.sh
EOF

cat >> ~/.bash_profile <<EOF
source ~/.virtualenvwrapper-conf.sh
EOF

source ~/.virtualenvwrapper-conf.sh

function create-pyenv-if-needed {
    pushd ~

    for envname in $@; do
        if [ ! -e ~/$envname ]; then
            virtualenv env -p python3
        fi
    done

    popd
}

function mkvirtualenv-if-needed {
    for envname in $@; do
        $(lsvirtualenv | grep -q "$envname") || mkvirtualenv "$envname" -p /usr/bin/python3.4
    done
}
