[root@dea_44 tmp]# cat audit_resotre.sh
#!/bin/bash
# RHEL6 REL7 is verified.
# use file_backup.sh to backup file data
# check tar.gz :tar -ztvf file.tar.gz
# restore
# ./$0 $1

if [ "`id -un`" != "root" -a "`id -un`" != "simon" ]; then
    echo "[FAIL]Should be executed by root"
    exit 0
fi
if [ ! -f "$1" ]; then
    echo "[FAIL] Should use list file as parameter to notice path need to be backup : $0 list.log"
    exit 0
fi

LIST_FILE=$1
## NEW_FILE_LIST is for rm space line

NEW_LIST_FILE="/tmp/NEW_LIST_FILE_`date +%Y_%m%d_%H`.log"
sed '/^$/d' $LIST_FILE > $NEW_LIST_FILE

## check and backpup list file
for i in `cat $NEW_LIST_FILE`
do
	if [ -f "$i" ];then
	#echo $i YES
	mv $i $i.`date +%Y%m%d-%H%M`.bak
else
	echo $i NO need backup
	fi
done

cd /
#tar -zxvf /tmp/audit_backup_*.tar.gz -C /opt/traffix/sdc/
tar -zxvf /tmp/audit_backup_*.tar.gz
#sleep 3
echo " -- file restore finished -- "