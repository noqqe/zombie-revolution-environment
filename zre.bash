#!/bin/bash
# zre.bash: zombie revolution environment simulator
# Copyright: (C) 2010 Florian Baumann <flo@noqqe.de>
# License: GPL-3 <http://www.gnu.org/licenses/gpl-3.0.txt>
# Date: Thursday 2010-10-14

### initial setting for your environment ######################################
# number of citizens by default
humans=500
zombies=500

# random sleeptime between events in seconds.
# 5 - 10 seconds are recommended
mintime=7
maxtime=10

### these things could happen #################################################

# the wonder of life
human_born() {
    ((humans++))
    local born=$(($RANDOM % 5 + 1))
    echo -n "BORN: 1 human was born. "
    case $born in 
        1) echo -n "it was a cold night, about 9 month ago..." ;;
        2) echo -n "he will be the next bofh." ;;
        3) echo -n "it's a pirate! argh." ;;
        4) echo -n "his name is bob." ;;
        5) echo -n "her name is alice." ;;
    esac
    echo " $humans humans alive."
}

# another wonder of life
zombie_born() {
    ((zombies++))
    local born=$(($RANDOM % 5 + 1))
    echo -n "BORN: 1 zombie awaked! "
    case $born in 
        1) echo -n "omg. it's michael jackson. " ;;
        2) echo -n "coffee at his grave." ;;
        3) echo -n "it's dr. hills project." ;;
        4) echo -n "brains. uargh." ;;
        5) echo -n "vegetarian zombie. grains!" ;;
    esac
    echo " $zombies zombies alive."

}

# the end of life..
human_die() {
    ((humans--))
    local die_reason=$(($RANDOM % 3 + 1))
    echo -n "DIED: 1 humand died. "
    case $die_reason in
        1) echo -n "he ran into a rake." ;;
        2) echo -n "his lolcat killed him." ;;
        3) echo -n "judgement: electric chair for useless use of cat in bashscripts." ;;
    esac
    echo " $humans humans alive."
     
}

# just kidding. zombies can't die.
zombie_die() {
    ((zombies--))
    local die_reason=$(($RANDOM % 3 + 1))
    echo -n "DIED: 1 zombie died. "
    case $die_reason in
        1) echo -n "farmished, maybe?" ;;
        2) echo -n "he watched the sunrise." ;;
        3) echo -n "he lost his legs." ;;
    esac
    echo " $zombies zombies alive."
}


# the zombies need braiiins!
zombie_attack() {
    local attack_message=$((RANDOM % 5 + 1 ))
    echo -n "ATTACK: " 
    case $attack_message in 
        1) echo -n "zombies raid a farm near the city!" ;;
        2) echo -n "zombies raid a pet shop!" ;;
        3) echo -n "zombies raid a liquoer store. drunken zombies crossing." ;;
        4) echo -n "zombies hijacked a garbage truck! it crashed into the non-swimmer's pool." ;;
		5) echo -n "do you know the movie \"braindeath\"? the zombie with his lawnmower? he's here. exactly." ;;
    esac
    echo 
    attack_by zombies
} 

# counter posion?!
human_attack() {
    local attack_message=$((RANDOM % 5 + 1 ))
    echo -n "ATTACK: "
    case $attack_message in 
        1) echo -n "humans developed counter-poison. a new hope?" ;;
        2) echo -n "the army sent a huge amount of weapons to the civils." ;;
        3) echo -n "humans raid the zombies headerquarter" ;;
        4) echo -n "the humans requested an airstrike by the nato. and get it." ;;
        5) echo -n "there is no zombie content without shotguns. humans attack zombies with thier shotguns " ;;
		6) echo -n "zombies and themself"
    esac
    echo
    attack_by humans
}


# lets have a look at the stats 
infos() {
    local info=$(($RANDOM % 2 + 1))
    case $info in
        1) echo "INFO: humans:$humans - fights won:$humans_won - round=$round" ;;
        2) echo "INFO: zombies:$zombies - fights won: $zombies_won - round=$round" ;;
    esac
}

zombie_support() {
    local size=$(($RANDOM % $zombies + 1))
	local support=$(($RANDOM % 4 + 1))
    zombies=$(($zombies + $size))
    
    echo -n "SUPPORT: "
    case $support in 
        1) echo -n "some zombies called friends to destroy the humans." ;;
        2) echo -n "a green toxic cloud over the graveyard results?" ;;
        3) echo -n "another graveyard has opened." ;; 
        4) echo -n "what has a dogs head, a cats tail, and brains all over its face? A Zombie coming out of the pet store."
    esac
    echo " the zombies get $size undeads support. $zombies zombies alive"
}

human_support() {
    local size=$(($RANDOM % $humans + 1))
    humans=$(($humans + $size))
    
	local support_msg=$(($RANDOM % 3 + 1))
    echo -n "SUPPORT: "
    case $support_msg in 
        1) echo -n "some policemen joined the humans." ;;
        2) echo -n "some evil ninjas joined the humans" ;;
        3) echo -n "saving private ryan. zombie edition" ;; 
    esac
    echo " the humans get $size people support. $humans humans alive"
}

### system functions ###########################################################
# normal attack 
attack_by() {
    if [ $1 = zombies ]; then
        attackers=$(($RANDOM % $zombies + 2))
        defenders=$(($RANDOM % $humans + 2))
        if [ $attackers -gt $defenders ]; then
            ((zombies_won++))
            victims=$(($RANDOM % $defenders + 1))
            humans=$(($humans - $victims))
            winner=zombies
            loser=humans
        else
            ((humans_won++))
            victims=$(($RANDOM % $attackers + 1))
            zombies=$(($zombies - $victims))
            winner=humans
            loser=zombies
        fi 
    elif [ $1 = humans ]; then
        attackers=$(($RANDOM % $humans + 2))
        defenders=$(($RANDOM % $zombies + 2))
        if [ $attackers -gt $defenders ]; then
            ((humans_won++))
            victims=$(($RANDOM % $defenders + 1))
            zombies=$(($zombies - $victims))
            winner=humans
            loser=zombies
        else
           ((zombies_won++)) 
            victims=$(($RANDOM % $attackers + 1))
            humans=$(($humans - $victims))
            winner=zombies
            loser=humans
        fi 

    fi
    echo "ATTACK: $attackers $winner vs. $defenders $loser. $winner win. $victims $loser died." 
}

# and the winner is... who's still alive.
population_zero() {
    if [ $humans -le 0 ] ; then
        echo "STATUS: ZOMBIES WIN!"
        echo "* HUMANS: 0 - FIGHTS WON: $humans_won"
        echo "* ZOMBIES: $zombies - FIGHTS WON: $zombies_won"
        echo "* ROUNDS: $round"
        exit 0
    elif [ $zombies -le 0 ]; then
        echo "STATUS: HUMANS WIN!"
        echo "* HUMANS: $humans - FIGHTS WON: $humans_won"
        echo "* ZOMBIES: 0 - FIGHTS WON: $zombies_won"
        echo "* ROUNDS: $round"
        exit 0
    fi
}


# ctrl+c got to be a awesome end of the world
trap world_explode INT
world_explode() {
    echo
    echo "END: suddenly... the whole world explodes. bam."
    echo "* HUMANS: $humans - FIGHTS WON: $humans_won"
    echo "* ZOMBIES: $zombies - FIGHTS WON: $zombies_won"
    echo "* ROUNDS: $round"
    exit 0
}


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
echo "STATUS: $humans humans and $zombies zombies live there.    "
echo "INFO: let's start the story...                             "
sleep 3

# counting the events
round=1

# fights won for stats
humans_won=0
zombies_won=0

# choose a randon event from defined functions
while true ; do

    event=$(($RANDOM %10 +1))
    ((round++))
    case $event in 
        1) human_born ;;
        2) zombie_born ;;
        3) zombie_attack ;;
		4) human_attack ;;
        5) infos ;;
        6) human_die ;;
        7) zombie_die ;;
        8) zombie_support ;;
		9) humans_support ;;
        *) echo "STATUS: the world is...buggy." ; exit 1 ;;
    esac

    population_zero
    sleeptime=$(($RANDOM % $maxtime + $mintime))
    sleep $sleeptime
done
