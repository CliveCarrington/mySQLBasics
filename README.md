# mySQLBasics
A repository to contain my musings about managing my MySQL databases on AWS and localls

I've taken the approach of creating a single script containing a set of simple SQL scripts.

The basic set up is to create an SQL script using sqldump and save that to an AWS S3 bucket. This script can then be pulled down
to either the same server or to a different server.
There is also a set up options to list databases and tables on the current server and the SQL scripts available.

Pre-requisite is a working s3cmd on the server, with the shared secret from the s3 bucket installed.

