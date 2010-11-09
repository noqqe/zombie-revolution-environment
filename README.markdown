#zombie (r)evolution environment 
================================

the zombie (r)evolution environment simulator (i just call it zre) is kind of... uhm...yeah. 
that's still the problem. i dunno what it really is. once, in a lazy night i got to 
get away from my work. i thought about a tiny "world" written in bash and randomization of events
which could happen _in_ the world. 

i am briefly talking about a tiny bash script, which generates his own tiny
story of a world and the battle of two "sides". so i wrote up the zre to 
let humans fight against zombies. that's it. 

who's gonna win? its $RANDOM's decision. 

playing with zombies
--------------------

usage is simple. get it and run zre.bash.

    $ git clone git://github.com/noqqe/zombie-revolution-environment.git
    $ cd zombie-revolution-environment
	$ ./zre.bash

see zre.example for gameplay.

rules
-----

both sides got _strength_ and _defense_ skills. 
skills are around 100 points. each human/zombie got 100 skillpoints in
defense and strength. 

lets' have a look at the example: humans attack zombies.

    strength example: 50 humans * 100 strength-points = 5000 strength-points
    defense example: 50 zombies * 80 defense-points = 4000 defense-points
    fight: humans 5000 strength vs. zombies 4000 defense
    result: humans win.

basic stats for humans:

    humans_off=100
    humans_deff=100

basic stats for zombies.

    zombies_off=120
    zombies_deff=80

create new events by yourself
-----------------------------

zre is using bash functions to create a event. it's very easy to
add own events to zre. 

 * create a function in events/ 
 * you can use the template in doc/
 * define your special stuff in there
 * run zre.bash


bugs and ideas
-------------

please report it! would be great if anyone of you got further ideas.

