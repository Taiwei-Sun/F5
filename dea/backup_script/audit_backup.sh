#!/bin/bash
#../data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/dictionaries/ALL/1469035570736/Diameter.xml
#../data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/dictionaries/ALL/1469035570736/internals/internalData.xml
#../data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/dictionaries/ALL/latestVersion.xml
if [ "`id -un`" != "root" -a "`id -un`" != "simon" ]; then
    echo "[FAIL]Should be executed by root"
    exit 0
fi

mkdir -p /opt/traffix/sdc/audit_test
cd /opt/traffix/sdc/audit_test
#cat /opt/traffix/sdc/data/backup/audit/ALL/15*/*.xml  | grep configPath > test.log
_AUDIT=`ls ../data/backup/audit/ALL/1[3-7]*/*.* | tail -n 1`
cat $_AUDIT| grep configPath > test.log

##<entry key="configPath16">../data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/flowManager/ALL/1533744563562</entry>

sed -i 's/^<entry key="configPath.*">//' test.log
#add audit,users,customStatistics
#_AUDIT=`ls ../data/backup/audit/ALL/1[3-7]*/internals/*.* | tail -n 1`
# for original config using,move to upper
#_AUDIT=`ls ../data/backup/audit/ALL/1[3-7]*/*.* | tail -n 1`
_USERS=`ls ../data/backup/users/ALL/1[3-7]*/*.* | tail -n 1`
_STATI=`ls ../data/backup/customStatistics/ALL/1[3-7]*/*.* | tail -n 1`
#echo $_AUDIT
#echo $_USERS
#echo $_STATI

##../data/backup/audit/ALL/1533744563562/audit.xml
##../data/backup/users/ALL/1532419271749/users.properties
##../data/backup/customStatistics/ALL/1504556070661/customStatistics.txt
_AUDIT=`dirname $_AUDIT`'</entry>'
_USERS=`dirname $_USERS`'</entry>'
_STATI=`dirname $_STATI`'</entry>'
echo $_AUDIT >> test.log
echo $_USERS >> test.log
echo $_STATI >> test.log

cp test.log test2.log
sed -i 's/<\/entry>$/\/*.*/' test2.log
##../data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/flowManager/ALL/1533744563562/*.xml
##../data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/flowManager/ALL/1533744563562/flowManager.xml

cp test.log test3.log
sed -i 's/<\/entry>$/\/internals\/*.*/' test3.log
##../data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/flowManager/ALL/1533744563562/internals/*.xml
##../data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/flowManager/ALL/1533744563562/internals/internalData.xml

sed -i 's/<\/entry>$//' test.log
##../data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/flowManager/ALL/1533744563562
cp test.log test4.log
sed -i 's/\/1[3-7].*/\/*.*/' test4.log
##../data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/flowManager/ALL/*.xml
##../data/backup/NEO_SDC/DEAEMSX01_traffix_config_mgr-config1/flowManager/ALL/latestVersion.xml

echo ../data/backup/alarms/NEO_EMS_nmsagent1/alarms.xml > test5.log
echo ../data/backup/alarms/NEO_EMS_nmsagent1/latestVersion.xml  >> test5.log
echo ../data/backup/alarms/NEO_EMS_nmsagent1/internals/internalData.xml >> test5.log

cat test2.log > testall.log
cat test3.log >> testall.log
cat test4.log >> testall.log
cat test5.log >> testall.log
sed -i 's/../\/opt\/traffix\/sdc/' testall.log

NEW_LIST_FILE="/tmp/audit_list_`hostname`_`date +%Y-%m-%d_%H`.log"
cat /dev/null > $NEW_LIST_FILE
for i in `cat testall.log`
do
	if [ ! -f "$i" ];then
	echo NOT found $i for backup
	else
	echo $i >>  $NEW_LIST_FILE
	fi
done

bak_file=audit_backup_`hostname`_`date +%Y-%m-%d`.tar.gz
#bak_file=audit_backup_`date +%Y-%m-%d`.tar.gz
tar -zcpPf /tmp/$bak_file `cat $NEW_LIST_FILE`
echo -e '\n\n'
echo -e 'execute finished!\n'

echo And you can execute following at new EMS
echo ./audit_restore.sh $NEW_LIST_FILE

echo -e '\n\n##########\nDO not forget to clooect these two files'
echo /tmp/$bak_file
echo $NEW_LIST_FILE
echo -e '\n##########\n'
