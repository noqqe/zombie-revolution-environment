#!/bin/bash

# this is the sql module to write statistical informations to a mysql database
# use with care. the basic database structure can be found in doc/zre_database.sql
# use:
# mysql -u root -p <DBNAME> < doc/zre_database.sql

zresql() {

    couchsend='curl -s -o /dev/null -X PUT http://127.0.0.1:5984/zre/'`python  -c "import uuid; print uuid.uuid1()"`' -d'
    case "$1" in
        kill) $couchsend '{"doc_type":"kill", "side":"'$2'", "kills": '$3'}' ;;
        death) $couchsend '{"doc_type":"death", "side":"'$2'"}' ;;
        born) $couchsend '{"doc_type":"born", "side":"'$2'"}' ;;
        win) $couchsend '{"doc_type":"win", "side":"'$2'", "survivors":'$3'}' ;;
        support) $couchsend '{"doc_type":"support", "side":"'$2'", "size":'$3'}' ;;
        weather) $couchsend '{"doc_type":"weather", "weather":"'$2'"}' ;;
        stats) $couchsend '{"doc_type":"stats", "side":"'$2'", "stat":"'$3'", "statchange":'$4', "type":"'$5'"}' ;;
        buildings) $couchsend '{"doc_type":"buildings", "side":"'$2'", "building":"'$3'", "size":'$4', "finish":'$5'}' ;;
        *) echo "Error in Usage:"; echo "Options: born | death | kill | win | support | weather | stats | buildings" ;;
    esac
}

