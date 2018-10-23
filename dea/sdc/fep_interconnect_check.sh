#!/bin/bash

HOST="172.18.9.183"
USER="tacm_dea"
PASSWD="tacm_dea@1234"
DATE=`date +%Y%m%d_%H%M`


grep 'Cannot route the answer back' /opt/traffix/sdc/logs/fep-p-sctp/fep/fep.*  > /tmp/`hostname`_FilterFep_"$DATE".log
grep 'Cannot route the answer back' /opt/traffix/sdc/logs/fep-r-sctp/fep/fep.*  >> /tmp/`hostname`_FilterFep_"$DATE".log


if [ -s /tmp/`hostname`_FilterFep_"$DATE".log ]; then
echo 'End_of_File' >> /tmp/`hostname`_FilterFep_"$DATE".log

ftp -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
cd /opt/ftp/tacm_dea/cpfcheck
lcd /tmp
put `hostname`_FilterFep_"$DATE".log
quit
END_SCRIPT

/bin/sed -i 's/Cannot route the answer back//g' /opt/traffix/sdc/logs/fep-p-sctp/fep/fep.*
/bin/sed -i 's/Cannot route the answer back//g' /opt/traffix/sdc/logs/fep-r-sctp/fep/fep.*

else
echo 'End_of_File' >> /tmp/`hostname`_FilterFep_"$DATE".log

ftp -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
cd /opt/ftp/tacm_dea/cpfcheck
lcd /tmp
put `hostname`_FilterFep_"$DATE".log
quit
END_SCRIPT
fi

if [ ! -d /root/FilterFep/ ]; then
mkdir /root/FilterFep/
fi

mv /tmp/`hostname`_FilterFep_"$DATE".log  /root/FilterFep/`hostname`_FilterFep_"$DATE".log
unset DATE
