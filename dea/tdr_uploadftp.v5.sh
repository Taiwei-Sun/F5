[root@sdc reports]# cat testmtdr.sh 
#!/bin/sh
###2018 1217 v5. for upload tdr > one
#echo > /tmp/uploaded_log.txt
#host1="172.18.207.10"
#id1="user1"
#pw1="user123"
#remodir1="/home/user1/"

host1="172.17.34.18"
host3="172.16.22.147"

id1="pdpftp"
pw1="DEA2tvm"
remodir1="dea_data"

id3="cdrftp"
pw3="2016#Cdrexe"
remodir3="/CMD/CDR/TWM/F5SDC"


localdir="/opt/traffix/reports/tdr"
tfile="/tmp_file"

if [ ! -d "$localdir$tfile" ]; then
mkdir "$localdir$tfile"
fi

if [ ! -d "$localdir/tmp_tarfile" ]; then
mkdir "$localdir/tmp_tarfile"
fi

if [ ! -d "$localdir/tmp_tartfile2" ]; then
mkdir -p "$localdir/tmp_tarfile2"
fi

if [ ! -d "/tmp/ftp_dump" ]; then
mkdir "/tmp/ftp_dump"
fi

ftp_upload(){
find /opt/traffix/reports/tdr -maxdepth 1 -mmin -30 -type f  -exec basename {} \; > /tmp/tdrmputlist.log
cat /tmp/tdrmputlist.log | while read line
do
cp -a $localdir/$line $localdir/tmp_file/$line".upload"
#ls -l $localdir/tmp_file/$line".upload" >> /tmp/uploaded_log.txt
done
ls -l $localdir/tmp_file/ >> /tmp/uploaded_log.txt
cp -a $localdir/tmp_file/* /tmp/ftp_dump/

echo "open $host1
user $id1 $pw1
lcd $localdir$tfile
binary
cd $remodir1
mput *
bye
" | ftp -vin

echo `hostname`_`date +%Y%m%d%H%M%S`"--"$host1 >> /tmp/uploaded_log.txt

echo "open $host3
user $id3 $pw3
lcd $localdir$tfile
binary
cd $remodir3
mput *
bye
" | ftp -vin

echo `hostname`_`date +%Y%m%d%H%M%S`"--"$host3 >> /tmp/uploaded_log.txt

mv -f $localdir$tfile/* $localdir/tmp_tarfile/.
}

## 
alarm_log(){
echo `hostname`_`date +%Y%m%d%H%M%S` >> /tmp/uploaded_log.txt
echo $alarm_sign  >> /tmp/uploaded_log.txt
ls -l /opt/traffix/reports/tdr  >> /tmp/uploaded_log.txt
echo "######################" >> /tmp/uploaded_log.txt
#echo OK!
}

check_tdr(){
TDR_N=`find /opt/traffix/reports/tdr -maxdepth 1 -mmin -30 -type f  -exec basename {} \; | wc -l `
    case $TDR_N in
        0)
            alarm_sign="No TDR file found !! "
            alarm_log
            ;;
        1)
            alarm_sign="Tdr correct as one"
            alarm_log
	    ftp_upload
            ;;
        *)
            alarm_sign="Tdr found more than one, abnormal !!"
#            echo "Tdr found more than one, abnormal !!"
            alarm_log
	    ftp_upload
            ;;
    esac
exit 0
}
check_tdr