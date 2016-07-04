#!/bin/sh

set -e

: ${DATAPORTEN_CLIENTID:?"Need to set DATAPORTEN_CLIENTID non-empty"}
: ${DATAPORTEN_CLIENTSECRET:?"Need to set DATAPORTEN_CLIENTSECRET non-empty"}
: ${DOKUWIKI_SUPERUSER:?"Need to set DOKUWIKI_SUPERUSER non-empty"}
: ${DOKUWIKI_TITLE:?"Need to set DOKUWIKI_TITLE non-empty"}
: ${DOKUWIKI_LICENSE:?"Need to set DOKUWIKI_LICENSE non-empty"}

sed -i '/dataporten-key/c\\$conf["plugin"]["oauth"]["dataporten-key"] = "'${DATAPORTEN_CLIENTID}'";' /var/www/conf/local.php
sed -i '/dataporten-secret/c\\$conf["plugin"]["oauth"]["dataporten-secret"] = "'${DATAPORTEN_CLIENTSECRET}'";' /var/www/conf/local.php
sed -i '/license/c\\$conf["license"] = "'${DOKUWIKI_LICENSE}'";' /var/www/conf/local.php
sed -i '/title/c\\$conf["title"] = "'${DOKUWIKI_TITLE}'";' /var/www/conf/local.php
sed -i "/superuser/c\$conf['superuser'] = '@${DOKUWIKI_SUPERUSER}';" /var/www/conf/local.php

#sed -i 's/{REPLACE_ID}/'${DATAPORTEN_CLIENTID}'/g' /var/www/conf/local.php
#sed -i 's/{REPLACE_SECRET}/'${DATAPORTEN_CLIENTSECRET}'/g' /var/www/conf/local.php
#sed -i 's/{REPLACE_SUPERUSER}/'${DOKUWIKI_SUPERUSER}'/g' /var/www/conf/local.php
#sed -i 's/{REPLACE_TITLE}/'${DOKUWIKI_TITLE}'/g' /var/www/conf/local.php
#sed -i 's/{REPLACE_LICENSE}/'${DOKUWIKI_LICENSE}'/g' /var/www/conf/local.php

if [ ! -f /var/dokuwiki-storage/conf/user.auth.php ]; then
    mv /users.auth.php /var/dokuwiki-storage/conf/users.auth.php
fi

if [ ! -f /var/www/conf/acl.auth.php ]; then
  touch /var/www/conf/acl.auth.php
  chmod 777 /var/www/conf/acl.auth.php

  touch /rolesets.json
  echo ${DATAPORTEN_ROLESETS} > /rolesets.json

  php /change.php
fi

chown -R www-data:www-data /var/www
chown -R www-data:www-data /var/dokuwiki-storage

exec /usr/bin/supervisord -c /etc/supervisord.conf
