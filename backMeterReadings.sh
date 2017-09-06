#!/bin/bash

/bin/rm -f ./backup/meterReadings.sql


# p = Ass1ngt0n

mysqldump --opt -u pi_manage -p  measurements meterReadings > ./backup/meterReadings.sql

mysql -u pi_manage -p backupMeasurements < ./backup/meterReadings.sql

