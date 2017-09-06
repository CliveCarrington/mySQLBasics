#!/bin/bash

/bin/rm -f ./backup/meterReadings.sql


# p = Ass1ngt0n

# takes structure and data from meterReading in measurements and creates a 
# SQL command file to recreate it.

mysqldump --opt -u pi_manage -p  measurements meterReadings > ./backup/meterReadings.sql


Takes the SQL command file and applies it to the backup database
mysql -u pi_manage -p backupMeasurements < ./backup/meterReadings.sql

