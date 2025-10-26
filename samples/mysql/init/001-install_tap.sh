#!/bin/bash
# This script will be run by the MySQL entrypoint after the DB is ready.

# 1. Create the 'tap' database.
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS tap;"

# 2. Connect to the 'tap' database and then execute the mytap.sql script.
mysql -t -u root -p"$MYSQL_ROOT_PASSWORD" tap < /mytap/mytap.sql