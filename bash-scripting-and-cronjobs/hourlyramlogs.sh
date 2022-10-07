#!/usr/bin/env bash
# A bash script to run at every hour, saving system memory (RAM) usage to a specified file
# and at midnight it sends the content of the file to a specified email address, then starts over for the new day.

LOGFILE="/var/log/ramlogs/hourlyramlog"

SENDTIME=$(date +%H:%M)

[[ ! -d "/var/log/ramlogs" ]] && mkdir -p /var/log/ramlogs/

if [ "$SENDTIME" == "00:00" ]; then
	yesterday=$(date -d "yesterday" '+%Y-%m-%d')
	echo "Please find attached cloudmendy.tech server ram log for $yesterday" | mutt -s "RAM usage report for cloudmendy" devops@cloud.com -a $LOGFILE
	rm -rf $LOGFILE
fi

echo "-------------------------------------$(date +%H:%M:%S)------------------------------------" >> $LOGFILE
free -h >> $LOGFILE
