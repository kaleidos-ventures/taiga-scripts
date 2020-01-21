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
  if [ "$VERSION_ID" = "18.04" ]; then
    apt-install-if-needed postgresql-10 postgresql-contrib \
        postgresql-doc-10 postgresql-server-dev-10
  elif [ "$VERSION_ID" = "16.04" ]; then
    apt-install-if-needed postgresql-9.5 postgresql-contrib-9.5 \
        postgresql-doc-9.5 postgresql-server-dev-9.5
  fi

    sudo -u postgres createuser --superuser $USER &> /dev/null
    sudo -u postgres createdb $USER &> /dev/null

    touch ~/.setup/postgresql
fi
