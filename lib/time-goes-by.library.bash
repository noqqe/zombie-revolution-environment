# Everyday a quote to cheer up or to lose hope
time_goes_by() {
    local another_day=$(( $RANDOM % 10 + 1 ))
    case $another_day in
        1)  echo -n "DAY $day: One more day trying to survive...";;
        2)  echo -n "DAY $day: The zombies are in great shape today. You'd better not get out.";;
        3)  echo -n "DAY $day: It is a good day to die.";;
        4)  echo -n "DAY $day: The sun hardly shines today, the humans left are cold and feel their end coming.";;
        5)  echo -n "DAY $day: Zombies are everywhere. I've seen one sleeping under my bed this morning.";;
        6)  echo -n "DAY $day: Today even the sun didn't wake up. Bad day in perspective...";;
        7)  echo -n "DAY $day: This is the end. Beautiful friend. The end.";;
        8)  echo -n "DAY $day: It s a beautiful day to build a brand new world.";;
        9)  echo -n "DAY $day: First rays of the new rising sun.";;
        10) echo -n "DAY $day: Dear George, people are nasty outside. They try to eat our brains. Please send me a laser gun."
    esac
        echo 
}
