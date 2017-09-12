#!/bin/bash

set -e

echo "[ ****************** ] Starting Endpoint of Application"
if ! [ -d "/var/www/mapasculturais" ] || ! [ -d "/var/www/mapasculturais/src" ]; then
    echo "Application not found in /var/www/mapasculturais - cloning now..."
    if [ "$(ls -A /var/www/mapasculturais)" ]; then
        echo "WARNING: /var/www/mapasculturais is not empty - press Ctrl+C now if this is an error!"
        ( set -x; ls -A; sleep 5 )
    fi
    echo "[ ****************** ] Cloning Project repository to tmp folder"
    
    git clone -b 'develop' $GIT_REPOSITORY /tmp/mapasculturais
    ls -la /tmp/mapasculturais

    echo "[ ****************** ] Copying Project from temporary folder to workdir"
    cp /tmp/mapasculturais -R /var/www/

    echo "[ ****************** ] Copying sample application configuration to real one"
    if ! [ -f "/var/www/mapasculturais/src/protected/application/conf/config.php" ]; then
        cp /var/www/mapasculturais/src/protected/application/conf/config.template.php /var/www/mapasculturais/src/protected/application/conf/config.php
    fi

    # echo "[ ****************** ] Changing owner and group from the Project to 'www-data' "
    # chown mapas:www-data -R /var/www/salic-br

    ls -la /var/www/mapasculturais

    echo "Complete! The application has been successfully copied to /var/www/mapasculturais"
fi

###### OBS: chamar no entrypoint : COPY . /srv/mapas/mapasculturais

# export PG_DB="${PG_DB:-mapasculturais}";
# export PG_PASS="${PG_PASS:-mapasculturais}";
# export PG_USER="${PG_USER:-mapasculturais}";
# export PG_HOST="${PG_HOST:-postgis}";



doctrine_conf="'doctrine.database'=>[";
doctrine_conf="$doctrine_conf 'dbname'=>'$PG_DB',";
doctrine_conf="$doctrine_conf 'password'=>'$PG_PASS',";
doctrine_conf="$doctrine_conf 'user'=>'$PG_USER',";
doctrine_conf="$doctrine_conf 'host'=>'$PG_HOST',";
doctrine_conf="$doctrine_conf ]";

su mapas -c sh << SUBSCRIPT
sed -i -z -e "s/'doctrine.database'[^]]*\]/$doctrine_conf/" /var/www/mapasculturais/src/protected/application/conf/config.php
SUBSCRIPT

exec "$@"