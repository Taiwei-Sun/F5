# PURPOSE 	: THIS SCRIPT IS TO MONITOR CURRENT CPF snmpcounter nodeTotalParsedMessage OID .1.3.6.1.4.1.27611.1.4.5.8.0  
# 	    	  SEND CUSTOMED SNMPTRAP ALARM WHEN BOTH SDC NODE TPS USAGE IS OVER DEFINED THRESHOLD AND LICENSETPS
# CREATED BY 	: LIM SAY PING
# CREATED DATE 	: 05 MAR 2015
# CUSTOMED SNMPTRAP VARIABLES: enterpriseSpecific, SITEID, LICUSAGE, SEVERITY
#!/bin/bash
#SOURCENODE=`cat /etc/hosts | grep vip-p-mgmt`
SOURCENODE=`cat /etc/hosts |grep CPF | awk '{print $2}'`
EXISTINGDATE=`date +"%Y-%m-%d %k:%M"`
#GLOBAL VARIABLES
SITEID=DRA-CHO
NMSSERVER=172.18.30.146
LICENSETPS=5000
MINORTHRESHOLD=50
MAJORTHRESHOLD=70
CRITICALTHRESHOLD=90
T1=0
T2=0
NODECOUNT=2
LICUSAGE=0
# SCRIPT runs on active server
netstat -atun| grep ":8080" 2>&1 > /dev/null
if [ $? = 0 ]; then	
	for H in $SOURCENODE 
	do
		V1=`snmpget -v1 -c TWMHPnms $H .1.3.6.1.4.1.27611.1.4.5.9.0  | awk '{print $4}'`
		if [ -z "$V1" ]; then
			V1=0
			NODECOUNT=NODECOUNT-1
		fi
		T1=$((T1+V1))
	done
	#WAIT FOR 1 MINUTE then CALCULATE BOTH CURRENT VALUE
	
	sleep 60
	for H in $SOURCENODE
	do
			V1=`snmpget -v1 -c TWMHPnms $H .1.3.6.1.4.1.27611.1.4.5.9.0  | awk '{print $4}'`
			if [ -z "$V1" ]; then
			V1=0
			fi
			T2=$((T2+V1))
	done
	TPS=$(((T2-T1) / (60*NODECOUNT)))
	LICUSAGE=$(((TPS*100) / LICENSETPS)) 
	# sending of TRAP if over license limit
	
	if [ "$LICUSAGE" -gt "$CRITICALTHRESHOLD" ]; then
		`snmptrap  -v  1  -c TWMHPnms $NMSSERVER .1.3.6.1.4.1.27611.1.4.6 "" 6 1 "" .1.3.6.1.4.1.27611.1.4.6.1 string $SITEID .1.3.6.1.4.1.27611.1.4.6.2 integer $LICUSAGE .1.3.6.1.4.1.27611.1.4.6.3 string "CRITCAL"`
		logger -i "SDC SITE - $SITEID , LICENSED TPS - $LICENSETPS, CURRENT TPS - $TPS, PERCENT OF LICENSE USAGE - $LICUSAGE, SEVERITY - CRITICAL"
	else
			if [ "$LICUSAGE" -gt "$MAJORTHRESHOLD" ]; then
				`snmptrap  -v  1  -c TWMHPnms $NMSSERVER .1.3.6.1.4.1.27611.1.4.6 "" 6 1 "" .1.3.6.1.4.1.27611.1.4.6.1 string $SITEID .1.3.6.1.4.1.27611.1.4.6.2 integer $LICUSAGE .1.3.6.1.4.1.27611.1.4.6.3 string "MAJOR"`
				logger -i "SDC SITE - $SITEID , LICENSED TPS - $LICENSETPS, CURRENT TPS - $TPS, PERCENT OF LICENSE USAGE - $LICUSAGE, SEVERITY - MAJOR"
			else
				if [ "$LICUSAGE" -gt "$MINORTHRESHOLD" ]; then
				`snmptrap  -v  1  -c TWMHPnms $NMSSERVER .1.3.6.1.4.1.27611.1.4.6 "" 6 1 "" .1.3.6.1.4.1.27611.1.4.6.1 string $SITEID .1.3.6.1.4.1.27611.1.4.6.2 integer $LICUSAGE .1.3.6.1.4.1.27611.1.4.6.3 string "MINOR"`
				logger -i "SDC SITE - $SITEID , LICENSED TPS - $LICENSETPS, CURRENT TPS - $TPS, PERCENT OF LICENSE USAGE - $LICUSAGE, SEVERITY - MINOR"
			fi
				fi
	fi
fi
