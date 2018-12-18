#!/bin/sh
###2018 1218 v6. for upload tdr > one
#echo > /tmp/uploaded_log.txt

#host1=("user1" "user123" "/home/user1" "172.18.207.10")
#host2=("user2" "user123" "/home/user2" "172.18.207.10")
host1=("pdpftp" "DEA2tvm" "dea_data" "172.17.34.18")
host2=("cdrftp" "2016#Cdrexe" "/CMD/CDR/TWM/F5SDC" "172.16.22.147")


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

check_tdr(){
TDR_N=`find /opt/traffix/reports/tdr -maxdepth 1 -mmin -30 -type f  -exec basename {} \; | wc -l `
    case $TDR_N in
        0)
            alarm_sign="No TDR file found !! "
            alarm_log
            exit 0
            ;;
        1)
            alarm_sign="Tdr correct as one"
            alarm_log
            pre_ftp
            ;;
        *)
            alarm_sign="Tdr found more than one, abnormal !!"
            alarm_log
            pre_ftp
            ;;
    esac
}

alarm_log(){
echo `hostname`_`date +%Y%m%d%H%M%S` >> /tmp/uploaded_log.txt
echo $alarm_sign  >> /tmp/uploaded_log.txt
ls -l /opt/traffix/reports/tdr  >> /tmp/uploaded_log.txt
echo "######################" >> /tmp/uploaded_log.txt
}

pre_ftp(){
for ((i=1; i<3; i++))
do
	eval value=\${host${i}[@]}
	#echo ${value[0]}  | awk -F " " '{print $1}'
	#echo ${value[0]}  | awk -F " " '{print $2}'
	id=`echo ${value[0]}  | awk -F " " '{print $1}'`
	pw=`echo ${value[0]}  | awk -F " " '{print $2}'`
	remodir=`echo ${value[0]}  | awk -F " " '{print $3}'`
	host=`echo ${value[0]}  | awk -F " " '{print $4}'`
	ftp_upload
#	echo $id,$pw,$remodir,$host
		sleep 5
done
}

ftp_upload(){
find /opt/traffix/reports/tdr -maxdepth 1 -mmin -30 -type f  -exec basename {} \; > /tmp/tdrmputlist.log
cat /tmp/tdrmputlist.log | while read line
do
cp -a $localdir/$line $localdir/tmp_file/$line".upload"
#ls -l $localdir/tmp_file/$line".upload" >> /tmp/uploaded_log.txt
done
ls -l $localdir/tmp_file/ >> /tmp/uploaded_log.txt
cp -a $localdir/tmp_file/* /tmp/ftp_dump/

echo "open $host
user $id $pw
lcd $localdir$tfile
binary
cd $remodir
mput *
bye
" | ftp -vin

echo `hostname`_`date +%Y%m%d%H%M%S`"--"$host >> /tmp/uploaded_log.txt



#mv -f $localdir$tfile/* $localdir/tmp_tarfile/.
}

check_tdr

mv -f $localdir$tfile/* $localdir/tmp_tarfile/.


