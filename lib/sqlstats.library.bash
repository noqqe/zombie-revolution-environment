#!/bin/bash

# this is the sql module to write statistical informations to a mysql database
# use with care. the basic database structure can be found in doc/zre_database.sql
# use:
# mysql -u root -p <DBNAME> < doc/zre_database.sql

sqlsend() {
    mysql -e "use $sqldb; $1" --user=$sqluser --password=$sqlpw --host=$sqlhost --batch
}


zresql() {

    #if [ $(sqlsend "show tables;" ; echo $?) -gt 0 ] ; then
    #    echo "Database Connection Error"
    #    return 1 
    #fi

    if [ "$sqlmodule" != "on" ]; then
        return 1
    fi
    
    if [ "$(which mysql ; echo $?)" -gt "0" ]; then
        echo "ERROR: Could not find mysql client. Disable SQL statistics in conf/sql.conf or install mysql client"
        return 1
    fi


    case "$1" in
        born) sqlsend "INSERT INTO zre_born VALUES (NULL , \"$2\", CURRENT_TIMESTAMP);" ;;
        death) sqlsend "INSERT INTO zre_death VALUES (NULL , \"$2\", CURRENT_TIMESTAMP);" ;;
        kill) sqlsend "INSERT INTO zre_kills VALUES (NULL , \"$2\", \"$3\", CURRENT_TIMESTAMP);" ;;
        win) sqlsend "INSERT INTO zre_wins VALUES (NULL, \"$2\", \"$3\", CURRENT_TIMESTAMP);" ;;
        support) sqlsend "INSERT INTO zre_support VALUES (NULL, \"$2\", \"$3\", CURRENT_TIMESTAMP);" ;;
        weather) sqlsend "INSERT INTO zre_weather VALUES (NULL, \"$2\", CURRENT_TIMESTAMP);" ;;
        stats) sqlsend "INSERT INTO zre_stats VALUES (NULL, \"$2\", \"$3\", \"$4\", \"$5\",CURRENT_TIMESTAMP);" ;;
        buildings) sqlsend "INSERT INTO zre_buildings VALUES (NULL, \"$2\", \"$3\", \"$4\", \"$5\", CURRENT_TIMESTAMP);" ;;
        *) echo "Error in Usage:"; echo "Options: born | death | kill | win | support | weather | stats | buildings" ;;
    esac
}

