#!/bin/bash

HOST="172.18.9.183"
USER="volte_dra"
PASSWD="volte_dra@1234"
DATE=`date +%Y%m%d_%H%M`


grep 'unable to resolve class' /opt/traffix/sdc/logs/cpf1/cpf/cpf.*  > /tmp/`hostname`_FilterCpf_"$DATE".log


if [ -s /tmp/`hostname`_FilterCpf_"$DATE".log ]; then
echo 'End_of_File' >> /tmp/`hostname`_FilterCpf_"$DATE".log
ftp -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
cd /opt/ftp/volte_dra/synccheck
lcd /tmp
put `hostname`_FilterCpf_"$DATE".log
quit
END_SCRIPT
/bin/sed -i 's/unable to resolve class//g' /opt/traffix/sdc/logs/cpf1/cpf/cpf.*
else
echo 'End_of_File' >> /tmp/`hostname`_FilterCpf_"$DATE".log
ftp -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
cd /opt/ftp/volte_dra/synccheck
lcd /tmp
put `hostname`_FilterCpf_"$DATE".log
quit
END_SCRIPT
fi

if [ ! -d /root/FilterCpf/ ]; then
mkdir /root/FilterCpf/
fi

mv /tmp/`hostname`_FilterCpf_"$DATE".log  /root/FilterCpf/`hostname`_FilterCpf_"$DATE".log
unset DATE
