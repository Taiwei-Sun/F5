#!/bin/bash

HOST="172.18.9.183"
USER="tacm_dea"
PASSWD="tacm_dea@1234"
DATE=`date +%Y%m%d_%H%M`
##DEAW variable decalration
#configure_folder
#DEAW01_CPF1=$(/bin/ls -lort /opt/traffix/sdc/data/backup/CHO_SDC/DEAEMSX01_traffix_config_mgr-config1/configuration/DEAW01_cpf1/ |tail -2 |egrep \d |awk '{print $8}')
#DEAW02_CPF1=$(/bin/ls -lort /opt/traffix/sdc/data/backup/CHO_SDC/DEAEMSX01_traffix_config_mgr-config1/configuration/DEAW02_cpf1/ |tail -2 |egrep \d |awk '{print $8}')
#DEAW_DEFAULT_LB_CONFIGURATION=$(/bin/ls -lort /opt/traffix/sdc/data/backup/CHO_SDC/ DEAEMSX01_traffix_config_mgr-config1/configuration/DEFAULT_LB_CONFIGURATION/ |tail -2 |egrep \d |awk '{print $8}')
#DEAW_FEP_P_SCTP=$(/bin/ls -lort /opt/traffix/sdc/data/backup/CHO_SDC/DEAEMSX01_traffix_config_mgr-config1/configuration/fep-p-sctp/ |tail -2 |egrep \d |awk '{print $8}')
#DEAW_FEP_R_SCTP=$(/bin/ls -lort /opt/traffix/sdc/data/backup/CHO_SDC/DEAEMSX01_traffix_config_mgr-config1/configuration/fep-r-sctp/ |tail -2 |egrep \d |awk '{print $8}')
#flowManager_folder
#DEAW_FLOWMGR=$(/bin/ls -lort /opt/traffix/sdc/data/backup/CHO_SDC/DEAEMSX01_traffix_config_mgr-config1/flowManager/ALL/ |tail -2 |egrep \d |awk '{print $8}')
##DEAWDEAW variable decalration


##DEAX variable decalration
#configure_folder
DEAX01_CPF1=$(/bin/ls -lort /opt/traffix/sdc/data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/configuration/DEAX01_cpf1/ |tail -2 |egrep \d |awk '{print $8}')
DEAX02_CPF1=$(/bin/ls -lort /opt/traffix/sdc/data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/configuration/DEAX02_cpf1/ |tail -2 |egrep \d |awk '{print $8}')
DEAX_DEFAULT_LB_CONFIGURATION=$(/bin/ls -lort /opt/traffix/sdc/data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/configuration/DEFAULT_LB_CONFIGURATION/ |tail -2 |egrep \d |awk '{print $8}')
DEAX_FEP_P_SCTP=$(/bin/ls -lort /opt/traffix/sdc/data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/configuration/fep-p-sctp/ |tail -2 |egrep \d |awk '{print $8}')
DEAX_FEP_R_SCTP=$(/bin/ls -lort /opt/traffix/sdc/data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/configuration/fep-r-sctp/ |tail -2 |egrep \d |awk '{print $8}')
#flowManager_folder
DEAX_FLOWMGR=$(/bin/ls -lort /opt/traffix/sdc/data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/flowManager/ALL/ |tail -2 |egrep \d |awk '{print $8}')
##DEAX variable decalration


##Create backup folder
if [ ! -d /DeaConfigureBackupDaily/ ]; then
mkdir /DeaConfigureBackupDaily/
fi
##Create backup folder


##DEAW get configure folder
#backup_configuration_of_DEAW01_cpf1_at_DEAEMS
#cd /opt/traffix/sdc/data/backup/CHO_SDC/DEAEMSX01_traffix_config_mgr-config1/configuration/DEAW01_cpf1/"$DEAW01_CPF1"/
#/bin/cp DEAW01_cpf1.xml /DeaConfigureBackupDaily/"$DATE"_DEAW01_cpf1.xml

#backup_configuration_of_DEAW02_cpf1_at_DEAEMS
#cd /opt/traffix/sdc/data/backup/CHO_SDC/DEAEMSX01_traffix_config_mgr-config1/configuration/DEAW02_cpf1/"$DEAW02_CPF1"/
#/bin/cp DEAW02_cpf1.xml /DeaConfigureBackupDaily/"$DATE"_DEAW02_cpf1.xml

#backup_configuration_of_DEAW_DEFAULT_LB_CONFIGURATION_at_DEAEMS
#cd /opt/traffix/sdc/data/backup/CHO_SDC/DEAEMSX01_traffix_config_mgr-config1/configuration/DEFAULT_LB_CONFIGURATION/"$DEAW_DEFAULT_LB_CONFIGURATION"/
#/bin/cp DEFAULT_LB_CONFIGURATION.xml /DeaConfigureBackupDaily/"$DATE"_DEAW_DEFAULT_LB_CONFIGURATION.xml

#backup_configuration_of_DEAW_FEP_P_SCTP_at_DEAEMS
#cd /opt/traffix/sdc/data/backup/CHO_SDC/DEAEMSX01_traffix_config_mgr-config1/configuration/fep-p-sctp/"$DEAW_FEP_P_SCTP"/
#/bin/cp fep-p-sctp.xml /DeaConfigureBackupDaily/"$DATE"_DEAW_fep-p-sctp.xml

#backup_configuration_of_DEAW_FEP_R_SCTP_at_DEAEMS
#cd /opt/traffix/sdc/data/backup/CHO_SDC/DEAEMSX01_traffix_config_mgr-config1/configuration/fep-r-sctp/"$DEAW_FEP_R_SCTP"/
#/bin/cp fep-r-sctp.xml /DeaConfigureBackupDaily/"$DATE"_DEAW_fep-r-sctp.xml

#backup_configuration_of_DEAW_FLOW_MANAGER_at_DEAEMS
#cd /opt/traffix/sdc/data/backup/CHO_SDC/DEAEMSX01_traffix_config_mgr-config1/flowManager/ALL/"$DEAW_FLOWMGR"/
#/bin/cp flowManager.xml /DeaConfigureBackupDaily/"$DATE"_DEAW_flowManager.xml

#backup_ip_address_info_at_SDC_and_EMS
#/sbin/ifconfig |egrep 'bond|eth|inet addr' > /DeaConfigureBackupDaily/"$DATE"_`hostname`_ifconfig

#backup_routing_file_at_SDC
#/bin/cp /opt/traffix/sdc/config/sysconfig/route-traffix_fep-fep-r-sctp /DeaConfigureBackupDaily/"$DATE"_`hostname`_route-traffix_fep-fep-r-sctp
#/bin/cp /opt/traffix/sdc/config/sysconfig/route-traffix_fep-fep-p-sctp /DeaConfigureBackupDaily/"$DATE"_`hostname`_route-traffix_fep-fep-p-sctp


##FTP_upload for DEAW
#ftp -n $HOST <<END_SCRIPT
#quote USER $USER
#quote PASS $PASSWD
#cd /opt/ftp/tacm_dea/synccheck
#lcd /DeaConfigureBackupDaily/
#put "$DATE"_DEAW01_cpf1.xml
#put "$DATE"_DEAW02_cpf1.xml
#put "$DATE"_DEAW_DEFAULT_LB_CONFIGURATION.xml
#put "$DATE"_DEAW_fep-p-sctp.xml
#put "$DATE"_DEAW_fep-r-sctp.xml
#put "$DATE"_DEAW_flowManager.xml
#put "$DATE"_`hostname`_ifconfig
#put "$DATE"_`hostname`_route-traffix_fep-fep-r-sctp
#put "$DATE"_`hostname`_route-traffix_fep-fep-p-sctp
#quit
#END_SCRIPT
#FTP_upload for DEAW

#unset DATE
#unset DEAW01_CPF1
#unset DEAW02_CPF1
#unset DEAW_DEFAULT_LB_CONFIGURATION
#unset DEAW_FEP_P_SCTP
#unset DEAW_FEP_R_SCTP
#unset DEAW_FLOWMGR


##DEAX get configure folder
#backup_configuration_of_DEAX01_cpf1_at_DEAEMS
cd /opt/traffix/sdc/data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/configuration/DEAX01_cpf1/"$DEAX01_CPF1"/
/bin/cp DEAX01_cpf1.xml /DeaConfigureBackupDaily/"$DATE"_DEAX01_cpf1.xml

#backup_configuration_of_DEAX02_cpf1_at_DEAEMS
cd /opt/traffix/sdc/data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/configuration/DEAX02_cpf1/"$DEAX02_CPF1"/
/bin/cp DEAX02_cpf1.xml /DeaConfigureBackupDaily/"$DATE"_DEAX02_cpf1.xml

#backup_configuration_of_DEAX_DEFAULT_LB_CONFIGURATION_at_DEAEMS
cd /opt/traffix/sdc/data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/configuration/DEFAULT_LB_CONFIGURATION/"$DEAX_DEFAULT_LB_CONFIGURATION"/
/bin/cp DEFAULT_LB_CONFIGURATION.xml /DeaConfigureBackupDaily/"$DATE"_DEAX_DEFAULT_LB_CONFIGURATION.xml

#backup_configuration_of_DEAX_FEP_P_SCTP_at_DEAEMS
cd /opt/traffix/sdc/data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/configuration/fep-p-sctp/"$DEAX_FEP_P_SCTP"/
/bin/cp fep-p-sctp.xml /DeaConfigureBackupDaily/"$DATE"_DEAX_fep-p-sctp.xml

#backup_configuration_of_DEAX_FEP_R_SCTP_at_DEAEMS
cd /opt/traffix/sdc/data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/configuration/fep-r-sctp/"$DEAX_FEP_R_SCTP"/
/bin/cp fep-r-sctp.xml /DeaConfigureBackupDaily/"$DATE"_DEAX_fep-r-sctp.xml

#backup_configuration_of_DEAX_FLOW_MANAGER_at_DEAEMS
cd /opt/traffix/sdc/data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/flowManager/ALL/"$DEAX_FLOWMGR"/
/bin/cp flowManager.xml /DeaConfigureBackupDaily/"$DATE"_DEAX_flowManager.xml

#backup_ip_address_info_at_SDC_and_EMS
/sbin/ifconfig |egrep 'bond|eth|inet addr' > /DeaConfigureBackupDaily/"$DATE"_`hostname`_ifconfig

#backup_routing_file_at_SDC
#/bin/cp /opt/traffix/sdc/config/sysconfig/route-traffix_fep-fep-r-sctp /DeaConfigureBackupDaily/"$DATE"_`hostname`_route-traffix_fep-fep-r-sctp
#/bin/cp /opt/traffix/sdc/config/sysconfig/route-traffix_fep-fep-p-sctp /DeaConfigureBackupDaily/"$DATE"_`hostname`_route-traffix_fep-fep-p-sctp

##FTP_upload for DEAX
ftp -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
cd /opt/ftp/tacm_dea/cfgdiff
lcd /DeaConfigureBackupDaily/
put "$DATE"_DEAX01_cpf1.xml
put "$DATE"_DEAX02_cpf1.xml
put "$DATE"_DEAX_DEFAULT_LB_CONFIGURATION.xml
put "$DATE"_DEAX_fep-p-sctp.xml
put "$DATE"_DEAX_fep-r-sctp.xml
put "$DATE"_DEAX_flowManager.xml
#put "$DATE"_`hostname`_ifconfig
#put "$DATE"_`hostname`_route-traffix_fep-fep-r-sctp
#put "$DATE"_`hostname`_route-traffix_fep-fep-p-sctp
quit
END_SCRIPT
##FTP_upload for DEAX

unset DATE
unset DEAX01_CPF1
unset DEAX02_CPF1
unset DEAX_DEFAULT_LB_CONFIGURATION
unset DEAX_FEP_P_SCTP
unset DEAX_FEP_R_SCTP
unset DEAX_FLOWMGR