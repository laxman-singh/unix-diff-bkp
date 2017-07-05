#!/bin/bash

###########################################################################
## SCRIPT TO TAKE DIFFERENTIAL BACKUP
## SCRIPT BY : Laxman Singh <laxman.nrlm@gmail.com>
###########################################################################

DAYS_TO_BACKUP=$1
RED='\033[0;31m'
GREEN='\033[32m'
ORANGE='\033[33m'
BLUE='\033[34m'
NC='\033[0m' # No Color

re='^[0-9]+$'
if [[ $# -eq 0 ]]; then
	echo -e "${RED}USAGE:\tDiffBAckup.sh NO_OF_DAYS_TO_TAKE_BACKUP${NC}"; exit 1
fi
if [[ ${DAYS_TO_BACKUP} != [0-9]* ]] ; then
   echo -e "${RED}error: Argument must be a number${NC}" >&2; exit 1
fi


echo -e "\n\n#################################################################\n \
	${ORANGE}Welcome to Differential Backup Program${NC}\n\
${GREEN} SCRIPT DEVELOPED BY : ${BLUE} Laxman Singh <laxman.nrlm@gmail.com>${NC}
#################################################################\n"

# find 20 days old files in ddugky directory and copy them to a temp location
echo -e "${GREEN} copying ${DAYS_TO_BACKUP} days old files from ddugky directory to ${RED}/tmp/DiffBackupDDUGKY_$(date +"%d-%m-%y")${NC}\n"
mkdir -p /tmp/DiffBackupDDUGKY_$(date +"%d-%m-%y")
cd /usr/local/tomcat7/webapps
find ddugky -maxdepth 30 -mtime -${DAYS_TO_BACKUP} -exec cp --parents '{}' /tmp/DiffBackupDDUGKY_$(date +"%d-%m-%y") ';'
echo -e "${GREEN} Done.......!!!! ${NC}\n"

# find 20 days old files in FILEFOLDER directory and copy them to a temp location
echo -e "${GREEN} copying ${DAYS_TO_BACKUP} days old files from FILEFOLDER directory to ${RED}/tmp/DiffBackupDDUGKY_$(date +"%d-%m-%y")${NC}\n"
#mkdir -p /tmp/DiffBackupDDUGKY_$(date +"%m-%d-%y")
find /FileFolder -maxdepth 5 -mtime -${DAYS_TO_BACKUP} -exec cp --parents '{}' /tmp/DiffBackupDDUGKY_$(date +"%d-%m-%y") ';'
echo -e "${GREEN} Done.......!!!! ${NC}\n"

# now compress files
echo -e "${ORANGE}compressing files..... Please wait ${NC}"
cd /tmp
tar -czf DiffBackupDDUGKY_$(date +"%d-%m-%y")"last_"${DAYS_TO_BACKUP}"_Days".tar.gz DiffBackupDDUGKY_$(date +"%d-%m-%y")

rm -rf DiffBackupDDUGKY_$(date +"%d-%m-%y")

echo -e "${GREEN}compressing done ........................ !! \n ${RED}deleting temp files ...!!${NC}\n"

echo -e "${ORANGE}############ Differential backup completed ######################${NC}\n\n"

