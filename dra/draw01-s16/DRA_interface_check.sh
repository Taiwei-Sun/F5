#!/bin/bash

HOST="172.18.9.183"
USER="volte_dra"
PASSWD="volte_dra@1234"
DATE=`date +%Y%m%d_%H%M`


grep eth /var/log/message*  > /tmp/`hostname`_CheckInterface_"$DATE".log


if [ -s /tmp/`hostname`_CheckInterface_"$DATE".log ]; then
echo 'End_of_File' >> /tmp/`hostname`_CheckInterface_"$DATE".log

ftp -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
cd /opt/ftp/volte_dra/cpfcheck
lcd /tmp
put `hostname`_CheckInterface_"$DATE".log
quit
END_SCRIPT

/bin/sed -i 's/eth//g' /var/log/message*

else
echo 'End_of_File' >> /tmp/`hostname`_CheckInterface_"$DATE".log

ftp -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
cd /opt/ftp/volte_dra/cpfcheck
lcd /tmp
put `hostname`_CheckInterface_"$DATE".log
quit
END_SCRIPT
fi

if [ ! -d /CheckInterface/ ]; then
mkdir /CheckInterface/
fi

mv /tmp/`hostname`_CheckInterface_"$DATE".log  /CheckInterface/`hostname`_CheckInterface_"$DATE".log
unset DATE
