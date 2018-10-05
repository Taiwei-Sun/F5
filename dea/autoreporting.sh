#!/bin/bash
# Change all report right to 744 
sleep 60
cd /opt/splunksearch/splunk/var/run/splunk
chmod 744 EMS_report*.csv

# Rename all reportname with timestamp suffix
# Move all renamed reports to /opt/traffix/autoreport
NEWPATH=/opt/traffix/autoreporting/

TS=`date +%Y%m%d`
for report in EMS_report*.csv
do
mv $report $NEWPATH${report%.*}-$TS.csv 
done

#ls -la $NEWPATH
#Check and remove report files that are older than 3 days.
find $NEWPATH -mtime +3 -type f -delete
