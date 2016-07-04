#!/bin/sh

set -e


sed -i 's/{REPLACE_ID}/'${DATAPORTEN_CLIENTID}'/g' /var/www/conf/local.php
sed -i 's/{REPLACE_SECRET}/'${DATAPORTEN_CLIENTSECRET}'/g' /var/www/conf/local.php
sed -i 's/{REPLACE_SUPERUSER}/'${DOKUWIKI_SUPERUSER}'/g' /var/www/conf/local.php
sed -i 's/{REPLACE_TITLE}/'${DOKUWIKI_TITLE}'/g' /var/www/conf/local.php
sed -i 's/{REPLACE_LICENSE}/'${DOKUWIKI_LICENSE}'/g' /var/www/conf/local.php

touch /var/www/conf/acl.auth.php
chmod 777 /var/www/conf/acl.auth.php

touch /rolesets.json
echo ${DATAPORTEN_ROLESETS} > /rolesets.json

php /change.php

chown -R www-data:www-data /var/www
chown -R www-data:www-data /var/dokuwiki-storage

exec /usr/bin/supervisord -c /etc/supervisord.conf
