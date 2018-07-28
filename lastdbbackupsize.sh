#!/bin/bash
REPORT=/tmp/`hostname`-backup-size-rpt-`date +"%d-%m-%Y"`.txt
ls *.db > /dev/null 2>&1
if [ ! $? -eq 0 ]; then
        echo "ERROR : you are not in db directory. cd to databse logs directory and run this script again. Your current directory `pwd`"
        exit 0;
else
        for db in `ls *.db`
                do
                        echo "$db `grep  "Bytes of media" ${db%.db}.lg|tail -1|awk '{ print $1 " " $(NF-3) " " $(NF-2) }'` " >> $REPORT
                done

fi
echo "Report location $REPORT"
