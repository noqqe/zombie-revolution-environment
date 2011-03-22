
### global attacking function
# this is the global attack function
# use it to easily attack the humans or zombies
#
# Usage:
#
# zombies attack the humans:
# attack_by zombies
# 
# humans attack the zombies:
# attack_by humans 
#
# you also can scale the max victims of losers side.
# the following will just take the half victims.
# attack_by humans 2 
#
# for example:
# random % defenders / factor 
# 12000 % 100 / 2 = 50
#
# otherwise it would be:
# random % defenders 
# 12000 % 100 = 100  


attack_by() {
	
	# limit max victims 
	# with given factor  
	local factor=$2
	if [ -z $2 ] ; then factor=1 ; fi
	
	# attackers are zombies 
	
    if [ $1 = zombies ]; then
    
		# get attackers and defenders
    	attackers=$(($RANDOM % $zombies + 2))
        defenders=$(($RANDOM % $humans + 2))

		# get strength and defense 
		off=$(($attackers * $zombie_strength))
		deff=$(($defenders * $human_defense))
        
		# zombies win thier attack
		if [ $off -gt $deff ]; then
            ((zombies_won++))
            victims=$(($RANDOM % $defenders / $factor + 1))
            zresql kill zombie $victims
            humans=$(($humans - $victims))
            winner=zombies
            loser=humans
        
		# human defense successfull
		elif [ $off -lt $deff ]; then
            ((humans_won++))
            victims=$(($RANDOM % $attackers / $factor + 1))
            zresql kill human $victims
            zombies=$(($zombies - $victims))
            winner=humans
            loser=zombies
        fi 
		echo "ATTACK: $attackers zombies vs. $defenders humans. $victims $loser died. $winner win. ($off|$deff)" 
    
	# attackers are humans 
		
	elif [ $1 = humans ]; then
        
		# get attackers and defenders by random
		attackers=$(($RANDOM % $humans + 2))
        defenders=$(($RANDOM % $zombies + 2))

		# get strength and defense
		off=$(($attackers * $human_strength))
		deff=$(($defenders * $zombie_defense))
      
		# humans win 
  		if [ $off -gt $deff ]; then
            ((humans_won++))
            victims=$(($RANDOM % $defenders / $factor + 1))
            zombies=$(($zombies - $victims))
            zresql kill human $victims
            winner=humans
            loser=zombies

		# zombies defense successfull
        elif [ $off -lt $deff ]; then
           ((zombies_won++)) 
            victims=$(($RANDOM % $attackers / $factor + 1))
            humans=$(($humans - $victims))
            zresql kill zombie $victims
            winner=zombies
            loser=humans
        fi 
		echo "ATTACK: $attackers humans vs. $defenders zombies. $victims $loser died. $winner win. ($off|$deff)" 
    fi

}
