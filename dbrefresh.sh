#!/bin/bash
#Database refresh script using FIFO
VERSION=1.0.0
USAGE="Usage    : $0 <backup.gz> <database> <environment> \nExample: $0 /backup/mfgdb.bak.gz /devl/db/devldb/devldb devl"
DESCRIPTION="Refresh a database from backup using FIFO"

#Check parameter and proenv
if [ -z $DLC ] ; then
    echo "Run this script from proenv"
    exit 1;

elif [ $# == 0 ] || [ ! -f $1 ] || [ ! -f $2 ] ; then
    echo -e $USAGE
    exit 1;
fi


#Create FIFO
FIFO1=/tmp/FIFO-kfp
mkfifo $FIFO1

#Unzip and restore DB using FIFO
gzip -d < $1 > $FIFO1 &
echo y|prorest $2 $FIFO1 -verbose

#Delete FIFO
rm -rf $FIFO1

#Verify
DBLOG=${2%.db}.lg
if [ $(tail -n 50 $DBLOG|grep "Full restore completed"|wc -l) -gt 0 ] ; then
         echo "Database $2 has been successfully refreshed"
else
         echo "Database refresh has failed check log file $DBLOG for details."
fi
