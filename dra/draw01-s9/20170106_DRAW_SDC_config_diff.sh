#!/bin/bash

HOST="172.18.9.183"
USER="volte_dra"
PASSWD="volte_dra@1234"
DATE=`date +%Y%m%d_%H%M`
##DRAW variable decalration
#configure_folder
#DRAW01_CPF1=$(/bin/ls -lort /opt/traffix/sdc/data/backup/DRA-CHO/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/DRAW01-S1_cpf1/ |tail -2 |egrep \d |awk '{print $8}')
#DRAW02_CPF1=$(/bin/ls -lort /opt/traffix/sdc/data/backup/DRA-CHO/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/DRAW01-S9_cpf1/ |tail -2 |egrep \d |awk '{print $8}')
#DRAW_DEFAULT_LB_CONFIGURATION=$(/bin/ls -lort /opt/traffix/sdc/data/backup/DRA-CHO/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/DEFAULT_LB_CONFIGURATION/ |tail -2 |egrep \d |awk '{print $8}')
#DRAW_FEP_GR_SCTP=$(/bin/ls -lort /opt/traffix/sdc/data/backup/DRA-CHO/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/fep-GR-SCTP/ |tail -2 |egrep \d |awk '{print $8}')
#DRAW_FEP_H_SCTP_C=$(/bin/ls -lort /opt/traffix/sdc/data/backup/DRA-CHO/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/fep-H-SCTP-C/ |tail -2 |egrep \d |awk '{print $8}')
#DRAW_FEP_H_SCTP_S=$(/bin/ls -lort /opt/traffix/sdc/data/backup/DRA-CHO/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/fep-H-SCTP-S/ |tail -2 |egrep \d |awk '{print $8}')
#DRAW_FEP_H_TCP=$(/bin/ls -lort /opt/traffix/sdc/data/backup/DRA-CHO/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/fep-H-TCP/ |tail -2 |egrep \d |awk '{print $8}')
#flowManager_folder
#DRAW_FLOWMGR=$(/bin/ls -lort /opt/traffix/sdc/data/backup/DRA-CHO/NEO-DRAEMS-01_traffix_config_mgr-config1/flowManager/ALL/ |tail -2 |egrep \d |awk '{print $8}')
##DRAW variable decalration

##DRAA variable decalration
#configure_folder
#DRAA01_CPF1=$(/bin/ls -lort /opt/traffix/sdc/data/backup/DRA-MQN/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/DRAA01-S1_cpf1/ |tail -2 |egrep \d |awk '{print $8}')
#DRAA02_CPF1=$(/bin/ls -lort /opt/traffix/sdc/data/backup/DRA-MQN/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/DRAA01-S9_cpf1/ |tail -2 |egrep \d |awk '{print $8}')
#DRAA_DEFAULT_LB_CONFIGURATION=$(/bin/ls -lort /opt/traffix/sdc/data/backup/DRA-MQN/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/DEFAULT_LB_CONFIGURATION/ |tail -2 |egrep \d |awk '{print $8}')
#DRAA_FEP_GR_SCTP=$(/bin/ls -lort /opt/traffix/sdc/data/backup/DRA-MQN/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/fep-GR-SCTP/ |tail -2 |egrep \d |awk '{print $8}')
#DRAA_FEP_H_SCTP_C=$(/bin/ls -lort /opt/traffix/sdc/data/backup/DRA-MQN/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/fep-H-SCTP-C/ |tail -2 |egrep \d |awk '{print $8}')
#DRAA_FEP_H_SCTP_S=$(/bin/ls -lort /opt/traffix/sdc/data/backup/DRA-MQN/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/fep-H-SCTP-S/ |tail -2 |egrep \d |awk '{print $8}')
#DRAA_FEP_H_TCP=$(/bin/ls -lort /opt/traffix/sdc/data/backup/DRA-MQN/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/fep-H-TCP/ |tail -2 |egrep \d |awk '{print $8}')
#flowManager_folder
#DRAA_FLOWMGR=$(/bin/ls -lort /opt/traffix/sdc/data/backup/DRA-MQN/NEO-DRAEMS-01_traffix_config_mgr-config1/flowManager/ALL/ |tail -2 |egrep \d |awk '{print $8}')
##DRAW variable decalration

##Create backup folder
if [ ! -d /DraConfigureBackupDaily/ ]; then
mkdir /DraConfigureBackupDaily/
fi
##Create backup folder

##DRAW get configure folder
#backup_configuration_of_DRAW01_cpf1_at_DRAEMS
#cd /opt/traffix/sdc/data/backup/DRA-CHO/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/DRAW01-S1_cpf1/"$DRAW01_CPF1"/
#/bin/cp DRAW01-S1_cpf1.xml /DraConfigureBackupDaily/"$DATE"_DRAW01-S1_cpf1.xml

#backup_configuration_of_DRAW02_cpf1_at_DRAEMS
#cd /opt/traffix/sdc/data/backup/DRA-CHO/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/DRAW01-S9_cpf1/"$DRAW02_CPF1"/
#/bin/cp DRAW01-S9_cpf1.xml /DraConfigureBackupDaily/"$DATE"_DRAW01-S9_cpf1.xml

#backup_configuration_of_DRAW_DEFAULT_LB_CONFIGURATION_at_DRAEMS
#cd /opt/traffix/sdc/data/backup/DRA-CHO/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/DEFAULT_LB_CONFIGURATION/"$DRAW_DEFAULT_LB_CONFIGURATION"/
#/bin/cp DEFAULT_LB_CONFIGURATION.xml /DraConfigureBackupDaily/"$DATE"_DRAW_DEFAULT_LB_CONFIGURATION.xml

#backup_configuration_of_DRAW_FEP_GR_SCTP_at_DRAEMS
#cd /opt/traffix/sdc/data/backup/DRA-CHO/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/fep-GR-SCTP/"$DRAW_FEP_GR_SCTP"/
#/bin/cp fep-GR-SCTP.xml /DraConfigureBackupDaily/"$DATE"_DRAW_fep-GR-SCTP.xml

#backup_configuration_of_DRAW_FEP_H_SCTP_C_at_DRAEMS
#cd /opt/traffix/sdc/data/backup/DRA-CHO/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/fep-H-SCTP-C/"$DRAW_FEP_H_SCTP_C"/
#/bin/cp fep-H-SCTP-C.xml /DraConfigureBackupDaily/"$DATE"_DRAW_fep-H-SCTP-C.xml

#backup_configuration_of_DRAW_FEP_H_SCTP_S_at_DRAEMS
#cd /opt/traffix/sdc/data/backup/DRA-CHO/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/fep-H-SCTP-S/"$DRAW_FEP_H_SCTP_S"/
#/bin/cp fep-H-SCTP-S.xml /DraConfigureBackupDaily/"$DATE"_DRAW_fep-H-SCTP-S.xml

#backup_configuration_of_DRAW_FEP_H_TCP_at_DRAEMS
#cd /opt/traffix/sdc/data/backup/DRA-CHO/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/fep-H-TCP/"$DRAW_FEP_H_TCP"/
#/bin/cp fep-H-TCP.xml /DraConfigureBackupDaily/"$DATE"_DRAW_fep-H-TCP.xml

#backup_configuration_of_DRAW_FLOW_MANAGER_at_DRAEMS
#cd /opt/traffix/sdc/data/backup/DRA-CHO/NEO-DRAEMS-01_traffix_config_mgr-config1/flowManager/ALL/"$DRAW_FLOWMGR"/
#/bin/cp flowManager.xml /DraConfigureBackupDaily/"$DATE"_DRAW_flowManager.xml

#backup_ip_address_info_at_SDC_and_EMS
/sbin/ifconfig |egrep 'bond|eth|inet addr' > /DraConfigureBackupDaily/"$DATE"_`hostname`_ifconfig.txt

#backup_routing_file_at_SDC_and_EMS
/bin/cp /opt/traffix/sdc/config/sysconfig/route-traffix_fep-fep-GR-SCTP /DraConfigureBackupDaily/"$DATE"_`hostname`_route-traffix_fep-fep-GR-SCTP
/bin/cp /opt/traffix/sdc/config/sysconfig/route-traffix_fep-fep-H-SCTP-C /DraConfigureBackupDaily/"$DATE"_`hostname`_route-traffix_fep-fep-H-SCTP-C
/bin/cp /opt/traffix/sdc/config/sysconfig/route-traffix_fep-fep-H-SCTP-S /DraConfigureBackupDaily/"$DATE"_`hostname`_route-traffix_fep-fep-H-SCTP-S
/bin/cp /opt/traffix/sdc/config/sysconfig/route-traffix_fep-fep-H-TCP /DraConfigureBackupDaily/"$DATE"_`hostname`_route-traffix_fep-fep-H-TCP


##FTP_upload for DRAW
ftp -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
cd /opt/ftp/volte_dra/synccheck
lcd /DraConfigureBackupDaily/
#put "$DATE"_DRAW01-S1_cpf1.xml
#put "$DATE"_DRAW01-S9_cpf1.xml
#put "$DATE"_DRAW_DEFAULT_LB_CONFIGURATION.xml
#put "$DATE"_DRAW_fep-GR-SCTP.xml
#put "$DATE"_DRAW_fep-H-SCTP-C.xml
#put "$DATE"_DRAW_fep-H-SCTP-S.xml
#put "$DATE"_DRAW_fep-H-TCP.xml
#put "$DATE"_DRAW_flowManager.xml
put "$DATE"_`hostname`_ifconfig.txt
put "$DATE"_`hostname`_route-traffix_fep-fep-GR-SCTP
put "$DATE"_`hostname`_route-traffix_fep-fep-H-SCTP-C
put "$DATE"_`hostname`_route-traffix_fep-fep-H-SCTP-S
put "$DATE"_`hostname`_route-traffix_fep-fep-H-TCP
quit
END_SCRIPT
#FTP_upload for DEAW

unset DATE
unset DRAW01_CPF1
unset DRAW02_CPF1
unset DRAW_DEFAULT_LB_CONFIGURATION
unset DRAW_FEP_GR_SCTP
unset DRAW_FEP_H_SCTP_C
unset DRAW_FEP_H_SCTP_S
unset DRAW_FEP_H_TCP
unset DRAW_FLOWMGR


##DRAA get configure folder
#backup_configuration_of_DRAA01_cpf1_at_DRAEMS
#cd /opt/traffix/sdc/data/backup/DRA-MQN/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/DRAA01-S1_cpf1/"$DRAA01_CPF1"/
#/bin/cp DRAA01-S1_cpf1.xml /DraConfigureBackupDaily/"$DATE"_DRAA01-S1_cpf1.xml

#backup_configuration_of_DRAA02_cpf1_at_DRAEMS
#cd /opt/traffix/sdc/data/backup/DRA-MQN/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/DRAA01-S9_cpf1/"$DRAA02_CPF1"/
#/bin/cp DRAA01-S9_cpf1.xml /DraConfigureBackupDaily/"$DATE"_DRAA01-S9_cpf1.xml

#backup_configuration_of_DRAA_DEFAULT_LB_CONFIGURATION_at_DRAEMS
#cd /opt/traffix/sdc/data/backup/DRA-MQN/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/DEFAULT_LB_CONFIGURATION/"$DRAA_DEFAULT_LB_CONFIGURATION"/
#/bin/cp DEFAULT_LB_CONFIGURATION.xml /DraConfigureBackupDaily/"$DATE"_DRAA_DEFAULT_LB_CONFIGURATION.xml

#backup_configuration_of_DRAA_FEP_GR_SCTP_at_DRAEMS
#cd /opt/traffix/sdc/data/backup/DRA-MQN/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/fep-GR-SCTP/"$DRAA_FEP_GR_SCTP"/
#/bin/cp fep-GR-SCTP.xml /DraConfigureBackupDaily/"$DATE"_DRAA_fep-GR-SCTP.xml

#backup_configuration_of_DRAA_FEP_H_SCTP_C_at_DRAEMS
#cd /opt/traffix/sdc/data/backup/DRA-MQN/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/fep-H-SCTP-C/"$DRAA_FEP_H_SCTP_C"/
#/bin/cp fep-H-SCTP-C.xml /DraConfigureBackupDaily/"$DATE"_DRAA_fep-H-SCTP-C.xml

#backup_configuration_of_DRAA_FEP_H_SCTP_S_at_DRAEMS
#cd /opt/traffix/sdc/data/backup/DRA-MQN/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/fep-H-SCTP-S/"$DRAA_FEP_H_SCTP_S"/
#/bin/cp fep-H-SCTP-S.xml /DraConfigureBackupDaily/"$DATE"_DRAA_fep-H-SCTP-S.xml

#backup_configuration_of_DRAA_FEP_H_TCP_at_DRAEMS
#cd /opt/traffix/sdc/data/backup/DRA-MQN/NEO-DRAEMS-01_traffix_config_mgr-config1/configuration/fep-H-TCP/"$DRAA_FEP_H_TCP"/
#/bin/cp fep-H-TCP.xml /DraConfigureBackupDaily/"$DATE"_DRAA_fep-H-TCP.xml

#backup_configuration_of_DRAA_FLOW_MANAGER_at_DRAEMS
#cd /opt/traffix/sdc/data/backup/DRA-MQN/NEO-DRAEMS-01_traffix_config_mgr-config1/flowManager/ALL/"$DRAA_FLOWMGR"/
#/bin/cp flowManager.xml /DraConfigureBackupDaily/"$DATE"_DRAA_flowManager.xml

#backup_ip_address_info_at_SDC_and_EMS
#/sbin/ifconfig |egrep 'bond|eth|inet addr' > /DraConfigureBackupDaily/"$DATE"_`hostname`_ifconfig.txt

#backup_routing_file_at_SDC_and_EMS
#/bin/cp /opt/traffix/sdc/config/sysconfig/route-traffix_fep-fep-GR-SCTP /DraConfigureBackupDaily/"$DATE"_`hostname`_route-traffix_fep-fep-GR-SCTP
#/bin/cp /opt/traffix/sdc/config/sysconfig/route-traffix_fep-fep-H-SCTP-C /DraConfigureBackupDaily/"$DATE"_`hostname`_route-traffix_fep-fep-H-SCTP-C
#/bin/cp /opt/traffix/sdc/config/sysconfig/route-traffix_fep-fep-H-SCTP-S /DraConfigureBackupDaily/"$DATE"_`hostname`_route-traffix_fep-fep-H-SCTP-S
#/bin/cp /opt/traffix/sdc/config/sysconfig/route-traffix_fep-fep-H-TCP /DraConfigureBackupDaily/"$DATE"_`hostname`_route-traffix_fep-fep-H-TCP


##FTP_upload for DRAA
#ftp -n $HOST <<END_SCRIPT
#quote USER $USER
#quote PASS $PASSWD
#cd /opt/ftp/volte_dra/synccheck
#lcd /DraConfigureBackupDaily/
#put "$DATE"_DRAA01_cpf1.xml
#put "$DATE"_DRAA02_cpf1.xml
#put "$DATE"_DRAA_DEFAULT_LB_CONFIGURATION.xml
#put "$DATE"_DRAA_route-traffix_fep-fep-GR-SCTP
#put "$DATE"_DRAA_route-traffix_fep-fep-H-SCTP-C
#put "$DATE"_DRAA_route-traffix_fep-fep-H-SCTP-S
#put "$DATE"_DRAA_fep-H-TCP.xml
#put "$DATE"_DRAA_flowManager.xml
#put "$DATE"_`hostname`_ifconfig.txt
#put "$DATE"_`hostname`_route-traffix_fep-fep-GR-SCTP
#put "$DATE"_`hostname`_route-traffix_fep-fep-H-SCTP-C
#put "$DATE"_`hostname`_route-traffix_fep-fep-H-SCTP-S
#put "$DATE"_`hostname`_route-traffix_fep-fep-H-TCP
#quit
#END_SCRIPT
#FTP_upload for DEAW

#unset DATE
#unset DEAA01_CPF1
#unset DEAA02_CPF1
#unset DEAA_DEFAULT_LB_CONFIGURATION
#unset DRAA_FEP_GR_SCTP
#unset DRAA_FEP_H_SCTP_C
#unset DRAA_FEP_H_SCTP_S
#unset DRAA_FEP_H_TCP
#unset DEAA_FLOWMGR
