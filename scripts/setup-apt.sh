function apt-install {
    for pkg in $@; do
        echo -e "[APT-GET] Installing package $pkg..."
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq -o DPkg::options::="--force-confdef" -o DPkg::options::="--force-confold" $pkg
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
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o DPkg::options::="--force-confdef" -o DPkg::options::="--force-confold" upgrade
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o DPkg::options::="--force-confdef" -o DPkg::options::="--force-confold" dist-upgrade
