# dataporten-dokuwiki-docker

This is a docker image for DokuWiki with Dataporten.

1 - To run it with docker, run

```$ docker pull uninettno/dataporten-dokuwiki-docker```

2 - Create an env.list:

```
DATAPORTEN_CLIENTID=********
DATAPORTEN_CLIENTSECRET=*******
DATAPORTEN_SCOPES=groups,userid,profile,userid-feide,email
DATAPORTEN_ROLESETS={"fc:org:uninett.no:unit:SEL-S": "delete", "fc:org:uninett.no":"admin"}

DOKUWIKI_LICENSE=cc-by-sa
DOKUWIKI_TITLE=Test_Site
DOKUWIKI_SUPERUSER=SUPER_USER_GROUP_SHOULD_BE_ONE_OF_DATAPORTEN_GROUPS

```

3 - Start the image with:

```$ docker run --env-file=YOUR_ENV_FILE -p DESIRED_PORT:80 -t uninettno/dataporten-dokuwiki-docker```


Roles of DokuWiki can be found here:

https://www.dokuwiki.org/acl#background_info

Licenses of DokuWiki can be found here:

https://github.com/splitbrain/dokuwiki/blob/master/conf/license.php
