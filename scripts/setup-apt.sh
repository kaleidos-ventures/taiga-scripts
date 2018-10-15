function apt-install {
    for pkg in $@; do
        echo -e "[APT-GET] Installing package $pkg..."
        sudo apt-get install -yq $pkg
    done
}


function apt-install-if-needed {
    for pkg in $@; do
        if package-not-installed $pkg; then
            apt-install $pkg
        fi
    done
}


function package-not-installed {
    test -z "$(sudo dpkg -s $1 2> /dev/null | grep Status)"
}

sudo apt-get -y update
sudo apt-get -yq upgrade
sudo apt-get -yq dist-upgrade
