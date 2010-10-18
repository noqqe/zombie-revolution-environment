#!/bin/bash
# zre.bash: zombie revolution environment simulator
# Copyright: (C) 2010 Florian Baumann <flo@noqqe.de>
# License: GPL-3 <http://www.gnu.org/licenses/gpl-3.0.txt>
# Date: Thursday 2010-10-14

### initial setting for your environment ######################################
### citizens
# number of citizens by default
humans=250
zombies=250

### sleeptime
# random sleeptime between events in seconds.
# 5 - 10 seconds are recommended
mintime=5
maxtime=7

### stats
# strength example: 50 humans * 100 strength-points = 5000 strength-points 
# defense example: 50 zombies * 80 defense-points = 4000 defense-points
# FIGHT: humans 5000 strength vs. zombies 4000 defense == humans win. 

# stats for humans. 
human_strength=100
human_defense=100

# stats for zombies. 
zombie_strength=120
zombie_defense=80


### these things could happen #################################################
# the wonder of life
human_born() {
    ((humans++))
    local born_msg=$(($RANDOM % 5 + 1))
    echo -n "BORN: 1 human was born. "
    case $born_msg in 
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
    local born_msg=$(($RANDOM % 5 + 1))
    echo -n "BORN: 1 zombie awaked! "
    case $born_msg in 
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
    local die_msg=$(($RANDOM % 3 + 1))
    echo -n "DIED: 1 humand died. "
    case $die_msg in
        1) echo -n "he ran into a rake." ;;
        2) echo -n "his lolcat killed him." ;;
        3) echo -n "judgement: electric chair for useless use of cat in bashscripts." ;;
    esac
    echo " $humans humans alive."
     
}

# just kidding. zombies can't die.
zombie_die() {
    ((zombies--))
    local die_msg=$(($RANDOM % 3 + 1))
    echo -n "DIED: 1 zombie died. "
    case $die_msg in
        1) echo -n "farmished, maybe?" ;;
        2) echo -n "he watched the sunrise." ;;
        3) echo -n "he lost his legs." ;;
    esac
    echo " $zombies zombies alive."
}


# the zombies need braiiins!
zombie_attack() {
    local attack_msg=$((RANDOM % 6 + 1 ))
    echo -n "ATTACK: " 
    case $attack_msg in 
        1) echo -n "zombies raid a farm near the city!" ;;
        2) echo -n "zombies raid a pet shop!" ;;
        3) echo -n "zombies raid a liquoer store. drunken zombies crossing." ;;
        4) echo -n "zombies hijacked a garbage truck! it crashed into the non-swimmer's pool." ;;
		5) echo -n "do you know the movie \"braindeath\"? the zombie with his lawnmower? he's here. exactly." ;;
		6) echo -n "rebellion!" ;;
    esac
    echo 
    attack_by zombies
} 

# the human attack
human_attack() {
    local attack_msg=$((RANDOM % 5 + 1 ))
    echo -n "ATTACK: "
    case $attack_msg in 
        1) echo -n "humans developed counter-poison. a new hope?" ;;
        2) echo -n "the army sent a huge amount of weapons to the civils." ;;
        3) echo -n "humans raid the zombies headerquarter." ;;
        4) echo -n "the humans requested an airstrike by the nato. and get it." ;;
        5) echo -n "there is no zombie content without shotguns. humans attack zombies with thier shotguns." ;;
    esac
    echo
    attack_by humans
}

# lets have a look at the stats 
infos() {
    local info_msg=$(($RANDOM % 2 + 1))
    case $info_msg in
        1) echo "INFO: humans:$humans($human_strength|$human_defense) wins:$humans_won round:$round" ;;
        2) echo "INFO: zombies:$zombies($zombie_strength|$zombie_defense) wins:$zombies_won round:$round" ;;
    esac
}

# the zombies get X undeads support
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

# the humans get X members support
humans_support() {
    local size=$(($RANDOM % $humans + 1))
    humans=$(($humans + $size))
    
	local support_msg=$(($RANDOM % 3 + 1))
    echo -n "SUPPORT: "
    case $support_msg in 
        1) echo -n "some policemen joined the humans." ;;
        2) echo -n "some evil ninjas joined the humans." ;;
        3) echo -n "saving private ryan. zombie edition." ;; 
    esac
    echo " the humans get $size people support. $humans humans alive"
}

stats_upgrade() {
	local upgrade_msg=$(($RANDOM % 4 + 1))
	echo -n "INFO: "
	case $upgrade_msg in 
        1) echo "humans built a wall around thier city. " ; stat human_defense ;;
        2) echo "zombies learned to handle chainsaws. rawr. " ; stat zombie_strength ;;
        3) echo "humans got ak-47s as weapons. " ; stat human_strength ;; 
        4) echo "zombies learned to resist against sunlight. " ; stat zombie_defense ;;
    esac 
}

### system functions ###########################################################
# global attacking function
attack_by() {
	
	# limit max victims 
	local factor=$2
	if [ -z $2 ] ; then factor=1 ; fi
	
    if [ $1 = zombies ]; then
        attackers=$(($RANDOM % $zombies + 2))
        defenders=$(($RANDOM % $humans + 2))
		off=$(($attackers * $zombie_strength))
		deff=$(($defenders * $human_defense))
        if [ $off -gt $deff ]; then
            ((zombies_won++))
            victims=$(($RANDOM % $defenders / $factor + 1))
            humans=$(($humans - $victims))
            winner=zombies
            loser=humans
        elif [ $off -lt $deff ]; then
            ((humans_won++))
            victims=$(($RANDOM % $attackers / $factor + 1))
            zombies=$(($zombies - $victims))
            winner=humans
            loser=zombies
        fi 
		echo "ATTACK: $attackers zombies vs. $defenders humans. $victims $loser died. $winner win. ($off|$deff)" 
    elif [ $1 = humans ]; then
        attackers=$(($RANDOM % $humans + 2))
        defenders=$(($RANDOM % $zombies + 2))
		off=$(($attackers * $human_strength))
		deff=$(($defenders * $zombie_defense))
        if [ $off -gt $deff ]; then
            ((humans_won++))
            victims=$(($RANDOM % $defenders / $factor + 1))
            zombies=$(($zombies - $victims))
            winner=humans
            loser=zombies
        elif [ $off -lt $deff ]; then
           ((zombies_won++)) 
            victims=$(($RANDOM % $attackers / $factor + 1))
            humans=$(($humans - $victims))
            winner=zombies
            loser=humans
        fi 
		echo "ATTACK: $attackers humans vs. $defenders zombies. $victims $loser died. $winner win. ($off|$deff)" 
    fi

}

# global stat upgrade function
stat() {
	local upgrade=$(($RANDOM % 100 / 4 + 1))
	if [ $1 = human_strength ]; then
		human_strength=$(($human_strength + $upgrade))
		echo "INFO: human strength was raised up to $human_strength"
	elif [ $1 = human_defense ]; then
		human_defense=$(($human_defense + $upgrade))
		echo "INFO: human defense was raised up to $human_defense"
	elif [ $1 = zombie_strength ]; then
		zombie_strength=$(($zombie_strength + $upgrade))
		echo "INFO: zombie strength was raised up to $zombie_strength"
	elif [ $1 = zombie_defense ]; then
		zombie_defense=$(($zombie_defense +$upgrade))
		echo "INFO: zombie defense was raised up to $zombie_defense"
	fi
}

# and the winner is... who's still alive.
population_zero() {
    if [ $humans -le 0 ] ; then
        echo "STATUS: ZOMBIES WIN!"
        echo "* HUMANS: 0 - FIGHTS WON: $humans_won - STATS: ($human_strength|$human_defense)"
        echo "* ZOMBIES: $zombies - FIGHTS WON: $zombies_won - STATS: ($zombie_strength|$zombie_defense)"
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
    echo "* HUMANS:$humans - FIGHTS WON:$humans_won - STATS:($human_strength|$human_defense)"
    echo "* ZOMBIES:$zombies - FIGHTS WON:$zombies_won - STATS:($zombie_strength|$zombie_defense)"
    echo "* ROUNDS:$round"
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
echo "STATUS: $humans humans ($human_strength|$human_defense) live there."
echo "STATUS: $zombies zombies ($zombie_strength|$zombie_defense) live there."
echo "INFO: let's start the story...                             "
sleep 3

# counting the events
round=1

# fights won for stats
humans_won=0
zombies_won=0

# choose a randon event from defined functions
while true ; do
    event=$(($RANDOM % 10 + 1))
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
		10) stats_upgrade ;;
        *) echo "STATUS: the world is...buggy." ; exit 1 ;;
    esac
	# check winner
    population_zero

	# fall asleep 
    sleeptime=$(($RANDOM % $maxtime + $mintime))
    sleep $sleeptime
done
