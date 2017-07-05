#!/bin/bash

###########################################################################
## SCRIPT TO TAKE DIFFERENTIAL BACKUP
## SCRIPT BY : Laxman Singh <laxman.nrlm@gmail.com>
###########################################################################


RED='\033[0;31m'
GREEN='\033[32m'
ORANGE='\033[33m'
blue='\033[34m'
NC='\033[0m' # No Color

echo -e "\n\n#################################################################\n \
	${ORANGE}Welcome to Differential Backup Program${NC}\n\
${GREEN} SCRIPT DEVELOPED BY : ${BLUE} Laxman Singh <laxman.nrlm@gmail.com>${NC}
#################################################################\n"

# find 20 days old files in ddugky directory and copy them to a temp location
echo -e "${GREEN} copying 20 days old files from ddugky directory to ${RED}/tmp/DiffBackupDDUGKY_$(date +"%m-%d-%y")${NC}\n"
mkdir -p /tmp/DiffBackupDDUGKY_$(date +"%m-%d-%y")
cd /usr/local/tomcat7/webapps
find ddugky -maxdepth 30 -mtime -20 -exec cp --parents '{}' /tmp/DiffBackupDDUGKY_$(date +"%m-%d-%y") ';'
echo -e "${GREEN} Done.......!!!! ${NC}\n"

# find 20 days old files in FILEFOLDER directory and copy them to a temp location
echo -e "${GREEN} copying 20 days old files from FILEFOLDER directory to ${RED}/tmp/DiffBackupDDUGKY_$(date +"%m-%d-%y")${NC}\n"
#mkdir -p /tmp/DiffBackupDDUGKY_$(date +"%m-%d-%y")
find /FileFolder -maxdepth 5 -mtime -20 -exec cp --parents '{}' /tmp/DiffBackupDDUGKY_$(date +"%m-%d-%y") ';' 
echo -e "${GREEN} Done.......!!!! ${NC}\n"

# now compress files
echo -e "${ORANGE}compressing files..... Please wait ${NC}"
cd /tmp
tar -czf DiffBackupDDUGKY_$(date +"%m-%d-%y").tar.gz DiffBackupDDUGKY_$(date +"%m-%d-%y")

rm -rf DiffBackupDDUGKY_$(date +"%m-%d-%y")

echo -e "${GREEN}compressing done ........................ !! \n ${RED}deleting temp files ...!!${NC}\n"

echo -e "${ORANGE}############ Differential backup complete ######################\n ${GREEN}Thank You... \n ${GREEN} (^_^) ${ORANGE}(^_^)${NC}"

echo -e "${GREEN}\n########################################${GREEN} (^_^) ${ORANGE}(^_^)${NC} ###############################################${NC}\n\n"
