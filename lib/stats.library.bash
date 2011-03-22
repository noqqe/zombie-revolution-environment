# global stat upgrade function
stat() {
	local upgrade=$(($RANDOM % 100 / 4 + 1))
	if [ $1 = human_strength ]; then
		human_strength=$(($human_strength + $upgrade))
        zresql stats human strength $upgrade plus
		echo "STATS: human strength was raised up to $human_strength"
	elif [ $1 = human_defense ]; then
		human_defense=$(($human_defense + $upgrade))
        zresql stats human defense $upgrade plus
		echo "STATS: human defense was raised up to $human_defense"
	elif [ $1 = zombie_strength ]; then
		zombie_strength=$(($zombie_strength + $upgrade))
        zresql stats zombie strength $upgrade plus
		echo "STATS: zombie strength was raised up to $zombie_strength"
	elif [ $1 = zombie_defense ]; then
		zombie_defense=$(($zombie_defense +$upgrade))
        zresql stats zombie defense $upgrade plus
		echo "STATS: zombie defense was raised up to $zombie_defense"
	fi
}
