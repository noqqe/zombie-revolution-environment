zombie (r)evolution environment 
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

the environment and it's events
-------------------------------

there's a handful of events in zre. 

* born: a new member gets born. no matter which side.

* die: the title already faced it. a member dies.

* info: prints some informations about a random side.

* attack: one side decides to attack the other.

* support: a side gets support. usually a random number of existing members.

* stats: upgrade of standard stats (100|100) to (112|100) for example

* nature: prints some informations about weather and sometimes a vulcano explodes or something.

* building: the humans build a rocket station or something. Seven steps to make the rocket ready!

attack rules
------------

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

daemon mode
-----------

there is a little --daemon gaming mode to print the output in a defined file. see conf/zre.conf for output file. 

since zre is used for web on zombies.n0q.org, there is a little debian init script in doc/ to use it on servers easily. this script is not nessecary for normal use. 

    ./zre-init start|stop|restart

attention:
do not use the init script without understanding/modificating it!

sql statistics module
----------------------

the sql statistics module could be enabled by 

    $ vim conf/sql.conf
    # turn sqlmodule on or off
    sqlmodule=on
    
   
this module is very additional. it is just used for additional informations for long time game environment, like in zombies.n0q.org. I'm gonna track some informations in a local mysql database. It's just because i love statistics. 

If you want to turn it on, fill in the following informations

    # turn sqlmodule on or off
    sqlmodule=on

    # sql database host
    sqlhost=localhost

    # sql database user
    sqluser=dbuser

    # sql database password
    sqlpw=dbpassword

    # sql database
    sqldb=sqldatabase
    
and at least, create the database and its structure:

    $ mysql -u root -p -e "create database DBNAME;"
    $ mysql -u root -p DBNAME < doc/zre_database.sql 

there is a little module in lib/sqlzre.library.bash. it is taking all the informations and send it automatically to the sql server. see the bash script for further details. 

    lib/sqlzre.library.bash
    
the module is turned off by default

bugs and ideas
-------------

please report it! would be great if anyone of you got further ideas.

