#!/bin/bash

# this is the couchdb module to write statistical informations to a couchdb database.
# use with care. 

zresql() {

    if [ "$couchdbmodule" != "on" ]; then
        return 1
    fi

    if [ "$(which curl &> /dev/null ; echo $?)" -gt "0" ]; then
        echo "ERROR: Could not find curl. Disable couchdb statistics in conf/couchdb.conf or install curl."
        return 1
    fi

    couchsend="curl -s -o /dev/null -X PUT http://$couchdbhost:$couchdbport/$couchdb/"`python  -c "import uuid; print uuid.uuid1()"`" -d"
    timestamp=`date "+%Y-%m-%d %H:%M:%S"`
    case "$1" in
        born) $couchsend '{"doc_type":"born", "side":"'$2'", "date":"'${timestamp}'"}' ;;
        buildings) $couchsend '{"doc_type":"buildings", "side":"'$2'", "building":"'$3'", "size":'$4', "finish":'$5', "date":"'${timestamp}'"}' ;;
        death) $couchsend '{"doc_type":"death", "side":"'$2'", "date":"'${timestamp}'"}' ;;
        kill) $couchsend '{"doc_type":"kill", "side":"'$2'", "kills":'$3', "date":"'${timestamp}'", "date":"'${timestamp}'"}' ;;
        support) $couchsend '{"doc_type":"support", "side":"'$2'", "size":'$3', "date":"'${timestamp}'"}' ;;
        stats) $couchsend '{"doc_type":"stats", "side":"'$2'", "stat":"'$3'", "statchange":'$4', "type":"'$5'", "date":"'${timestamp}'"}' ;;
        weather) $couchsend '{"doc_type":"weather", "weather":"'$2'", "date":"'${timestamp}'"}' ;;
        win) $couchsend '{"doc_type":"win", "side":"'$2'", "survivors":'$3', "date":"'${timestamp}'"}' ;;
        *) echo "Error in Usage:"; echo "Options: born | death | kill | win | support | weather | stats | buildings" ;;
    esac
}

