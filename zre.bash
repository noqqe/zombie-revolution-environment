#!/bin/bash
# zre.bash: zombie revolution environment simulator
# Copyright: (C) 2010 Florian Baumann <flo@noqqe.de>
# License: GPL-3 <http://www.gnu.org/licenses/gpl-3.0.txt>
# Date: Thursday 2010-10-14

### config ####################################################################

# include config 
source conf/zre.conf

### these things could happen #################################################

# parse events from event/
EVENTS="./events/*.event"
for event in $EVENTS
do
  source $event
done

### system functions ###########################################################

# parse library functions
LIBRARY="./lib/*.zre"
for lib in $LIBRARY
do
  source $lib
done

### create new world. this is the runtime #####################################
# welcome message
clear

echo "-------------------------------------------------------------"
echo "| _               _           _                             |"
echo "|| |__  _ __ __ _(_)_ __  ___| |                            |"
echo "|| '_ \| '__/ _\` | | '_ \/ __| |                            |"
echo "|| |_) | | | (_| | | | | \__ \_|                            |"
echo "||_.__/|_|  \__,_|_|_| |_|___(_)                            |"
echo "|-----------------------------------------------------------|"                        
echo "| zombie revolution environment simulator                   |" 
echo "-------------------------------------------------------------"
echo "STATUS: $humans humans ($human_strength|$human_defense) live there."
echo "STATUS: $zombies zombies ($zombie_strength|$zombie_defense) live there."
echo "INFO: let's start at day 1"

# sleep a while before first event
sleep 3


### runtime
while true ; do
	
	# parse events and count it
	random_event=$(($RANDOM % $(ls events/ | wc -l) + 1))
	
	# get random event
	event=$(for i in $(ls events/) ; do cat events/$i | grep "()" | sed -e 's/() {//g' ; done | sed -n ${random_event}p)
	
	# exec randomized event 
    $event
	
	# check winner
    population

	# increase day
	((day++))

	# fall asleep 
    sleeptime=$(($RANDOM % $maxtime + $mintime))
    sleep $sleeptime

done
