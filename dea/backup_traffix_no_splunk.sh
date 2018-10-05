#!/bin/bash

# No splunk version

# Cron safety valve
#set -x
basename=`basename $0`
pidfile=/var/tmp/$basename.pid

if [ -r $pidfile ]; then
        pidvalue=`cat $pidfile`
        pidcount=`ps -p $pidvalue|grep -c $basename|wc -l`
        if [ $pidcount -ne 0 ]; then
                # dead pidfile
                echo $$ > $pidfile
                if [ $? -ne 0 ]; then
                        echo Cant write $basename pid file |logger -i -t $basename -p daemon.notice
                        exit 1
                fi
        else
                # found live pid write error to syslog and exit
                echo Found $basename zombie pid $pidvalue exiting |logger -i -t $basename -p daemon.notice
                exit 1
        fi
else
        # No pid file create it
        echo $$ > $pidfile
        if [ $? -ne 0 ]; then
                echo Cant write $basename pid file |logger -i -t $basename -p daemon.notice
                exit 1
        fi
fi

TRAFFIX_DIR="/opt/traffix/sdc"
BACKUP_HOME="$TRAFFIX_DIR/utils/system/linux/backup_and_restore"

timestamp=`date +%Y%m%d%H%M%S`
# Log backup start time
echo SDC Backup started |logger -t SDC_backup

# Save cluster configuration
rm -f /tmp/crm_config.txt 2>/dev/null
su - -c "/usr/sbin/crm configure save /tmp/crm_config.txt &>/dev/null"
if [ $? -eq 0 ]; then
        echo Cluster config saved for backup 
else
        echo Cluster config backup failed 
fi

# Loop over list and make a new list with files found
while read line
do
	for filedir in $line
	do
		if [ -f $filedir ] || [ -d $filedir ]; then
			echo $filedir >> /tmp/filedirs_found.txt
		else
			# suppress warnings for comments
                        echo $line | grep '^#' &>/dev/null
                        if [ $? -eq 0 ]; then
                                :
                        else
                                if [ "$filedir" != "/opt/traffix/sdc/cpf/config/ss7" ]
                                then
                                    if [ "$filedir" == "/opt/splunk/var/lib/" ]
                                    then
                                        grep ^isManager /opt/traffix/sdc/config/sysconfig/traffix|grep true &> /dev/null
                                        if [ $? -eq 0 ]
                                        then
                                            echo WARNING $filedir not found
                                            echo WARNING Backup of $filedir failed|logger -t SDC_backup
                                        fi
                                    else
                                        echo WARNING $filedir not found
                                        echo WARNING Backup of $filedir failed|logger -t SDC_backup
                                    fi
                                fi
                        fi
		fi

	done
done < $BACKUP_HOME/files.txt

# Prepare for splunk backup incase splunk exists
#grep ^isManager /opt/traffix/sdc/config/sysconfig/traffix|grep true &> /dev/null
#if [ $? -eq 0 ]
#then
#${TRAFFIX_DIR}/utils/system/linux/backup_and_restore/splunk_roll_hot_buckets.sh start -auto
#fi

# Create a tar file
# Run 100 backups and continue when tar is ok
for ((i=1;i<=100;i++))
do
	if [ $i -eq 100 ]; then
		echo "Error SDC backup failed check syslog for errors"
		echo "Error $i SDC backup failed check syslog for errors"|logger -t SDC_backup
		exit 1
	fi

	# Add /tmp/filedirs_found.txt to backup list
	echo "/tmp/filedirs_found.txt" >> /tmp/filedirs_found.txt
	tar cf $BACKUP_HOME/backup-$HOSTNAME-$timestamp.tar -T /tmp/filedirs_found.txt --exclude=$BACKUP_HOME/*hot_v1_*
		if [ $? -eq 0 ]; then
				echo "Your backup file is backup-$HOSTNAME-$timestamp.tar"
				echo "SDC backup saved to backup-$HOSTNAME-$timestamp.tar" |logger -t SDC_backup
				break
		else
				# Delete bad tar
				rm -f backup-$HOSTNAME-$timestamp.tar
				echo $i |logger -t SDC_backup
				return
		fi
done
#added by SayPing
#gzip backup-$HOSTNAME-$timestamp.tar
rm -f /tmp/crm_config.txt 2>/dev/null
rm -f /tmp/filedirs_found.txt 

# Temp retention plan < 7 tars to be replaced with log rotate
# update 3 to 7 on 2015/2/25
tar_count=`ls -1 $BACKUP_HOME/backup-$HOSTNAME*|wc -l`
if [ $tar_count -gt 7 ]; then
        oldest=`ls -1rt $BACKUP_HOME/backup-$HOSTNAME*|head -1`
        \rm $oldest
	if  [ $? -eq 0 ]; then
        	echo Deleted $oldest |logger -t SDC_backup
	else
        	echo Error delete of $oldest failed|logger -t SDC_backup
	fi
fi

# Log backup end time
echo SDC Backup ended |logger -t SDC_backup