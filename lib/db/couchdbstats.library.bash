#!/bin/bash

# this is the sql module to write statistical informations to a mysql database
# use with care. the basic database structure can be found in doc/zre_database.sql
# use:
# mysql -u root -p <DBNAME> < doc/zre_database.sql

zresql() {

    couchsend='curl -s -o /dev/null -X PUT http://127.0.0.1:5984/zre/'`python  -c "import uuid; print uuid.uuid1()"`' -d'
    timestamp=`date "+%Y%m%dT%H%M%S"`
    case "$1" in
        born) $couchsend '{"doc_type":"born", "side":"'$2'", "date":"'${timestamp}'"}' ;;
        buildings) $couchsend '{"doc_type":"buildings", "side":"'$2'", "building":"'$3'", "size":'$4', "finish":'$5', "date":"'${timestamp}'"}' ;;
        death) $couchsend '{"doc_type":"death", "side":"'$2'", "date":"'${timestamp}'"}' ;;
        kill) echo '{"doc_type":"kill", "side":"'$2'", "kills":'$3', "date":"'${timestamp}'", "date":"'${timestamp}'"}' ;;
        support) $couchsend '{"doc_type":"support", "side":"'$2'", "size":'$3', "date":"'${timestamp}'"}' ;;
        stats) $couchsend '{"doc_type":"stats", "side":"'$2'", "stat":"'$3'", "statchange":'$4', "type":"'$5'", "date":"'${timestamp}'"}' ;;
        weather) $couchsend '{"doc_type":"weather", "weather":"'$2'", "date":"'${timestamp}'"}' ;;
        win) $couchsend '{"doc_type":"win", "side":"'$2'", "survivors":'$3', "date":"'${timestamp}'"}' ;;
        *) echo "Error in Usage:"; echo "Options: born | death | kill | win | support | weather | stats | buildings" ;;
    esac
}

