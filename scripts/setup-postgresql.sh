# postgresql.sh

function createdb-if-needed {
    for dbname in $@; do
        $(psql -l | grep -q "$dbname") || createdb "$dbname"
    done
}

function dropdb-if-needed {
    for dbname in $@; do
        $(psql -l | grep -q "$dbname") && dropdb "$dbname"
    done
}

if [ ! -e ~/.setup/postgresql ]; then
    apt-install-if-needed postgresql-9.5 postgresql-contrib-9.5 \
        postgresql-doc-9.5 postgresql-server-dev-9.5

    sudo -u postgres createuser --superuser $USER &> /dev/null
    sudo -u postgres createdb $USER &> /dev/null

    touch ~/.setup/postgresql
fi

