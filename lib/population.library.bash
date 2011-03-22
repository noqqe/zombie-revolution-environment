# and the winner is... who's still alive.
population() {
    if [ $humans -le 0 ] ; then
        echo "STATUS: ZOMBIES WIN!"
        echo "* HUMANS: 0 - FIGHTS WON: $humans_won - STATS: ($human_strength|$human_defense)"
        echo "* ZOMBIES: $zombies - FIGHTS WON: $zombies_won - STATS: ($zombie_strength|$zombie_defense)"
        echo "* DAYS: $day"
        zresql win zombie $zombies
        exit 0
    elif [ $zombies -le 0 ]; then
        echo "STATUS: HUMANS WIN!"
        echo "* HUMANS: $humans - FIGHTS WON: $humans_won"
        echo "* ZOMBIES: 0 - FIGHTS WON: $zombies_won"
        echo "* DAYS: $day"
        zresql win human $humans 
        exit 0
    fi

	# population limit 300.000 members
	if [ $humans -gt 300000 ] || [ $zombies -gt 300000 ]; then
		weather hard
		((day++))
	fi
}
