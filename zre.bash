#!/bin/bash
# zre.bash: zombie revolution environment simulator
# Copyright: (C) 2010 Florian Baumann <flo@noqqe.de>
# License: GPL-3 <http://www.gnu.org/licenses/gpl-3.0.txt>
# Date: Thursday 2010-10-14

### config ####################################################################

# include config 
source conf/zre.conf

# include local conf if exists
if [ -r conf/zre.local ]; then
    source conf/zre.local
fi

# include sql conf if exists
if [ -r conf/sql.conf ]; then
    source conf/sql.conf
fi

### these things could happen #################################################

# parse events from event/
EVENTS="./events/*.event"
for event in $EVENTS
do
  source $event
done

### system functions ###########################################################

# parse library functions
LIBRARY="./lib/*.library.bash"
for lib in $LIBRARY
do
  source $lib
done
# parse database-adapter functions
source lib/db/${database}stats.library.bash

# create pid file    
if [ -e $(pwd)/zre.pid ]; then
    rm $(pwd)/zre.pid
fi 
echo "$$" > $(pwd)/zre.pid

### create new world. this is the runtime #####################################

if [ "$1" == "--daemon" ]; then 

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


