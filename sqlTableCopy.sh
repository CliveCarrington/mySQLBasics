#!/bin/bash

# /bin/rm -f ./backup/testBackupScript.sql

if [ $# -lt 2 ]
then
        echo "Usage : $0 Signalnumber PID"
        exit
fi

case "$1" in

pull_struct)  echo "Pull Structure only"
	mysqldump --opt --add-drop-table --no-data -u pi_manage -pAss1ngt0n  $2 $3 > ./backup/$4.sql
    ;;
pull_data)  echo  "Pull Data into existing table"
	mysqldump --opt --skip-add-drop-table --no-create-info  -u pi_manage -pAss1ngt0n testDatabase testTable > ./backup/testBackupScriptData.sql
    ;;  
push_data)  echo  "Push Saved  SQL file"
# Takes the SQL command file and applies it to the backup database
	mysql -u pi_manage -pAss1ngt0n $2 < ./backup/$3.sql
	echo
	echo "list of the new copy database"
	echo
	mysql -u pi_manage -pAss1ngt0n testCopyDatabase < ./listRecords.sql
    ;;
9) echo  "Sending SIGKILL signal"
   ;;
*) echo "Signal number $1 is not processed"
   ;;
esac
exit
# p = Ass1ngt0n

# takes structure and data from meterReading in measurements and creates a 
# SQL command file to recreate it.
echo
echo " contents of the original table"
echo
mysql -u pi_manage -pAss1ngt0n testDatabase < ./listRecords.sql

mysqldump --opt --add-drop-table --no-data -u pi_manage -pAss1ngt0n  testDatabase testTable > ./backup/testBackupScript.sql

s3cmd put ./backup/testBackupScript.sql s3://len.carrington.mySQL/test.sql
sleep 5 
s3cmd get s3://len.carrington.mySQL/test.sql ./backup/testBackupScriptFromS3.sql
 

# Takes the SQL command file and applies it to the backup database
mysql -u pi_manage -pAss1ngt0n testCopyDatabase < ./backup/testBackupScript.sql

# Now lets see what the new table has in it

echo
echo "list of the new copy database"
echo
mysql -u pi_manage -pAss1ngt0n testCopyDatabase < ./listRecords.sql

# Now to add a record to the new table

mysql -u pi_manage -pAss1ngt0n testCopyDatabase < ./insertRecord.sql

# Now see what the database contains
echo
echo "list of the new copy database after adding an entry"
echo
mysql -u pi_manage -pAss1ngt0n testCopyDatabase < ./listRecords.sql


# Now to move the contents of the original table across

mysqldump --opt --skip-add-drop-table --no-create-info  -u pi_manage -pAss1ngt0n testDatabase testTable > ./backup/testBackupScriptData.sql
mysql -u pi_manage -pAss1ngt0n testCopyDatabase < ./backup/testBackupScriptData.sql

# Now see what the database contains
echo
echo "list of the new copy database after copying the data too"
echo
mysql -u pi_manage -pAss1ngt0n testCopyDatabase < ./listRecords.sql



