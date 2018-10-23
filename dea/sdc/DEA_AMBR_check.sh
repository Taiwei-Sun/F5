#!/bin/bash

HOST="172.18.9.183"
USER="tacm_dea"
PASSWD="tacm_dea@1234"
DATE=`date +%Y%m%d_%H%M`


grep 'AMBR not match' /opt/traffix/sdc/logs/cpf1/cpf/cpf*  > /tmp/`hostname`_CheckAMBR_"$DATE".log


if [ -s /tmp/`hostname`_CheckAMBR_"$DATE".log ]; then
echo 'End_of_File' >> /tmp/`hostname`_CheckAMBR_"$DATE".log

ftp -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
cd /opt/ftp/tacm_dea/ambrcheck
lcd /tmp
put `hostname`_CheckAMBR_"$DATE".log
quit
END_SCRIPT

/bin/sed -i 's/AMBR not match//g' /opt/traffix/sdc/logs/cpf1/cpf/cpf*

else
echo 'End_of_File' >> /tmp/`hostname`_CheckAMBR_"$DATE".log

ftp -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
cd /opt/ftp/tacm_dea/ambrcheck
lcd /tmp
put `hostname`_CheckAMBR_"$DATE".log
quit
END_SCRIPT
fi

if [ ! -d /CheckAMBR/ ]; then
mkdir /CheckAMBR/
fi

mv /tmp/`hostname`_CheckAMBR_"$DATE".log  /CheckAMBR/`hostname`_CheckABMR_"$DATE".log
unset DATE

