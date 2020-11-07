#!/usr/bin/env sh

## Cron restart
#rc-service crond restart

## REPOS
#REPOS
echo "http://ftp.icm.edu.pl/pub/Linux/distributions/alpine/v3.12/main" > /etc/apk/repositories
echo "http://ftp.icm.edu.pl/pub/Linux/distributions/alpine/v3.12/community" >> /etc/apk/repositories
echo "#http://ftp.icm.edu.pl/pub/Linux/distributions/alpine/edge/main" >> /etc/apk/repositories
echo "#http://ftp.icm.edu.pl/pub/Linux/distributions/alpine/edge/community" >> /etc/apk/repositories
echo "#http://ftp.icm.edu.pl/pub/Linux/distributions/alpine/edge/testing" >> /etc/apk/repositories


##system dependency
apk --update add docker \
	docker-compose \
	tree

## 
service docker start

## variables 
WORKSHOP_ROOT=`dirname "$0"`
echo ${WORKSHOP_ROOT}
MY_IP=`/sbin/ip -4 -o addr show dev eth1| awk '{split($4,a,"/");print a[1]}'`
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

docker-compose -f ${WORKSHOP_ROOT}/docker-compose.yaml up --no-recreate -d

echo "We are ready to go!!!!"
echo "Your ip is: ${MY_IP}"
echo -e "Adminer available via: ${GREEN}http://${MY_IP}:8080${NC} in your browser"
echo -e "Happy codding ${GREEN}:)${NC}"