# gem.sh

function gem-install {
    for pkg in $@; do
        echo -e "${cyan}[NPM] Installing package $pkg..."
        gem install $pkg
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

if [ ! -e ~/.setup/ruby ]; then
    touch ~/.setup/ruby

    rm -rf ~/.rvm

    curl -L https://get.rvm.io | bash -s stable
    source ~/.rvm/scripts/rvm
    echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc
    rvm install 2.1.2
    rvm use 2.1.2 --default
fi

source ~/.rvm/scripts/rvm
