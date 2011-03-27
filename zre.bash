#!/bin/bash
# zre.bash: zombie revolution environment simulator
# Copyright: (C) 2010 Florian Baumann <flo@noqqe.de>
# License: GPL-3 <http://www.gnu.org/licenses/gpl-3.0.txt>
# Date: Thursday 2010-10-14

### config ####################################################################

# include config 
if [ -r conf/zre.conf ]; then 
    source conf/zre.conf
else
    echo "ERROR: Could not find config"
    exit 1
fi

# include local conf if exists
if [ -r conf/zre.local ]; then
    source conf/zre.local
fi


### these things could happen #################################################

# parse events from event/
EVENTS="./events/*.event"
for event in $EVENTS
do
  source $event
done

### system functions ##########################################################

# parse library functions
LIBRARY="./lib/*.library.bash"
for lib in $LIBRARY
do
  source $lib
done

### statistic module ##########################################################

# include sql/couchdb conf and module if confiugred
if [ "$statisticmodule" = "sql" ]; then
    source conf/sql.conf
    source lib/db/sqlstats.library.bash
elif [ "$statisticmodule" = "couchdb" ]; then
    source conf/couchdb.conf
    source lib/db/couchdbstats.library.bash
else
    echo "Error by getting statistic module"
fi

### create new world. this is the runtime #####################################

if [ "$1" == "--daemon" ]; then 

    # create pid file    
    if [ -e $(pwd)/zre.pid ]; then
            rm $(pwd)/zre.pid
    fi
    echo "$$" > $(pwd)/zre.pid

    # welcome message
    welcome > $output

    # sleep a while before first event
    sleep 3

    ### runtime
    while true ; do
	
	   # parse events and count it
	   random_event=$(($RANDOM % $(ls events/ | wc -l) + 1))
	
        # execute random event
        $(for event in $(ls events/); do
            cat events/$event \
            | grep "()" \
            | sed -e 's/() {//g' 
            done | sed -n ${random_event}p
        )
	
	    # check winner
        population

        # daily message
        if [ ${daily_msg:-on} = on ]; then
            time_goes_by
        fi 
	
        # increase day
	    ((day++))

	    # fall asleep 
        sleeptime=$(($RANDOM % $maxtime + $mintime))
        sleep $sleeptime
    done >> $output

else 

    # welcome message
    welcome 

    # sleep a while before first event
    sleep 3

    ### runtime
    while true ; do
	
	   # parse events and count it
	   random_event=$(($RANDOM % $(ls events/ | wc -l) + 1))
	
        # execute random event
        $(for event in $(ls events/); do
            cat events/$event \
            | grep "()" \
            | sed -e 's/() {//g' 
            done | sed -n ${random_event}p
        )
	
	    # check winner
        population

        # daily message
        if [ ${daily_msg:-on} = on ]; then
            time_goes_by
        fi 
	
        # increase day
	    ((day++))

	    # fall asleep 
        sleeptime=$(($RANDOM % $maxtime + $mintime))
        sleep $sleeptime
    done
fi
