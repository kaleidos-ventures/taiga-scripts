# gem.sh

function gem-install {
    for pkg in $@; do
        echo -e "[GEM] Installing package $pkg..."
        gem install --user-install $pkg
    done
}

function gem-install-if-needed {
    for pkg in $@; do
        if gem-package-not-installed $pkg; then
            gem-install $pkg
        fi
    done
}

function gem-package-not-installed {
    test -z "$(gem list 2> /dev/null | grep "$1")"
}

cat > ~/.ruby-conf.sh <<EOF
export PATH=/home/$USER/.gem/ruby/1.9.1/bin:\$PATH
EOF

apt-install-if-needed ruby
source ~/.ruby-conf.sh
