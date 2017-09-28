#!/bin/bash

# /bin/rm -f ./backup/testBackupScript.sql

username="pi_manage"
pw="Ass1ngt0n"

if [ $# -lt 1 ]
then
        echo "Usage : $0 [pull_struct | pull_data | pull_table | push_data | list (Files)i | listDBs | listTables"
        exit
fi

if [ $1 = "-h" ]
then
case "$2" in
	
pull_struct)
	echo "Usage $0 pull_struct [database] [table] [output_filename]"
	echo "To create a new table (deleting the old one) with no data"
	;;
pull_data)
	echo "Usage $0 pull_struct [database] [table] [output_filename]"
	echo "To transfer data to an existing table"
	;;
pull_table)
	echo "Usage $0 pull_table [database] [table] [output_filename]"
	echo "To transfer table structure and data to a table of the same name in a new database"
	;;
push_data)
	echo "Usage $0 push_data [database] [input_filename]"
	echo "To push the saved table/data into an existing database." 
	;;
list)
	echo "Usage $0 list "
	echo "Lists the files that are currently available in the s3 bucket"
	;;
listDBs)
	echo "Usage $0 listDBs" 
	echo "To list the databases available on the current server"
	;;
listTables)
	echo "Usage $0 listTables [database]"
	echo "To list the tables available in the database on the current server"
	;;
esac
	exit
fi

case "$1" in

pull_struct)  echo "Pull Structure only"

	if [ -f ./.temp/$4.sql ] ; then
		rm -f ./.temp/$4.sql
	fi
	mysqldump --opt --add-drop-table --no-data -u $username -p$pw  $2 $3 > ./.temp/$4.sql
	echo "Now attempt to save it to len.carrington.mySQL"
	s3cmd put ./.temp/$4.sql s3://len.carrington.mySQL/$4.sql
    ;;
pull_data)  echo  "Pull Data from existing table"
	if [ -f ./.temp/$4.sql ] ; then
		rm -f ./.temp/$4.sql
	fi
	mysqldump --opt --skip-add-drop-table --no-create-info  -u $username -p$pw $2 $3 > ./.temp/$4.sql
	echo "Now attempt to save it to len.carrington.mySQL"
	s3cmd put ./.temp/$4.sql s3://len.carrington.mySQL/$4.sql
    ;;  
pull_table)  echo  "Pull Data from existing table"
	if [ -f ./.temp/$4.sql ] ; then
		rm -f ./.temp/$4.sql
	fi
	mysqldump --opt -u $username -p$pw $2 $3 > ./.temp/$4.sql
	echo "Now attempt to save it to len.carrington.mySQL"
	s3cmd put ./.temp/$4.sql s3://len.carrington.mySQL/$4.sql
    ;;  
push_data)  echo  "Push Saved  SQL file"
# Takes the SQL command file and applies it to the backup database
	if [ -f ./.temp/$3.sql ] ; then
		rm -f ./.temp/$3.sql
	fi
	echo "Attempt to retrieve it from len.carrington.mySQL"
	s3cmd get s3://len.carrington.mySQL/$3.sql ./.temp/$3.sql
	mysql -u $username -p$pw $2 < ./.temp/$3.sql
	echo
	echo "list of the new copy database"
	echo
	mysql -u $username -p$pw $2 < ./listRecords.sql
    ;;
list)	echo "The following files are available in the s3 bucket"
	s3cmd ls s3://len.carrington.mySQL
    ;;
listDBs)	echo "The following databases are available on this server"
	mysql -u $username -p$pw < ./listDatabases.sql
    ;;
listTables)	echo "The following tables are available on this server"
	mysql -u $username -p$pw $2 < ./listTables.sql
    ;;
*) 	echo "The command $1 is not known"
        echo "Usage : $0 [pull_struct | pull_data | pull_table | push_data | list (Files)i | listDBs | listTables"
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



