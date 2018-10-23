#!/bin/bash
#autoOverloadControlAlarm.sh 20180112 v2.2


splunkIP="172.18.9.183";
AT="tacm_dea";
PD="tacm_dea@1234";
nameDate=`hostname`_`date +%Y%m%d%H%M%S`;
logPath="/opt/traffix/sdc/logs/cpf1/cpf/statistics/CpfRawStatistic/statistics.log";



#add log to tmp log file, check tail process status
echo $nameDate > ${nameDate}_logs.log;

tail $logPath -n 1000 |egrep 'APT-DRA.*Sent Messages' >> ${nameDate}_logs.log;



#send tmp log file to Splunk by FTP
ftp -n $splunkIP <<END_SCRIPT
quote USER $AT
quote PASS $PD
binary
cd /opt/ftp/tacm_dea/APTTPScheck/
put ${nameDate}_logs.log
quit
END_SCRIPT


#reset tmp log file
rm -f ${nameDate}_logs.log

