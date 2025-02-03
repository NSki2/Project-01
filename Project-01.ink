/*
    Project 01
    
    Requirements (for 15 base points)
    - Create an interactive fiction story with at least 8 knots 
    - Create at least one major choice that the player can make
    - Reflect that choice back to the player
    - Include at least one loop
    
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than eight passages
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested)
    
    Make sure to list the items you changed for points in the Readme.md. I cannot guess your intentions!

*/

VAR speed = 0
VAR turning = 0
VAR acceleration = 0
VAR durability = 0
VAR strength = 0
VAR money = 1800
VAR power = ""
VAR place = 1
VAR water = -1

-> intro

== intro ==
You and your friends have enetered a boat racing competition at IU. The goal of the race is to get a duck down the river and across the finish line in your boat. There are six teams competing in total. Before racing, you must decide how to spend your budget of $1800. You will have to decide on one upgrade for each of these parts:
    -> boat_build
    
== function place_name ==
    
    {
        - place > 6:
            ~ place = 6
    }    
    
    {
        - place < 1:
            ~ place = 1
    }    

    {    
        - place == 1:
            ~ return "first"
        
        - place == 2:
            ~ return "second"
        
        - place == 3:
            ~ return "third"
            
        - place == 4:
            ~ return "fourth"
            
        - place == 5:
            ~ return "fifth"
            
        - place == 6:
            ~ return "last"
    
    }
        
    ~ return place
    
== function advance_water ==

    ~ water = water + 1
    
    {
        - water > 2:
            ~ water = 0
    }    
    
    {    
        - water == 0:
            ~ return "choppy"
        
        - water == 1:
            ~ return "smooth"
        
        - water == 2:
            ~ return "heavy current"
    
    }

    
        
    ~ return water

== boat_build ==
You have ${money}

+[materials] -> materials
+[motor] -> motor
+[propeller] -> propeller
+[steering] -> steering
+[special power] -> special_power
+[armor] -> armor
+[cosmetics] -> cosmetics
*[done] -> stats

== materials ==
* {money >= 600} [metal boat $600] 
    ~ durability += 4
    ~ strength += 2
    ~ money -= 600
    -> boat_build
* {money >= 400} [wood boat $400]
    ~ durability += 3
    ~ strength += 1
    ~ money -= 400
    -> boat_build
* {money >= 200} [plastic boat $200]
    ~ durability += 2
    ~ money -= 200
    -> boat_build
* {money >= 100} [inflatable boat $100]
    ~ durability += 1
    ~ money -= 100
    -> boat_build
+[go back] ->boat_build

== motor ==
* {money >= 500} [electric $500]
    ~ speed += 2
    ~ acceleration += 3
    ~ money -= 500
    -> boat_build
* {money >= 400} [gas $400]
    ~ speed += 2
    ~ acceleration += 2
    ~ money -= 400
    -> boat_build
* {money >= 400} [steam $400]
    ~ speed += 3
    ~ acceleration += 1
    ~ money -= 400
    -> boat_build
+[go back] -> boat_build

== propeller ==
* {money >= 400} [big propeller $400]
    ~ speed += 3
    ~ turning += 1
    ~ money -= 400
    -> boat_build
* {money >= 400} [small propeller $400]
    ~ speed += 1
    ~ turning += 3
    ~ money -= 400
    -> boat_build
+[go back] -> boat_build

== steering ==
* {money >= 100} [basic rudder $100]
    ~ turning += 1
    ~ money -= 100
    -> boat_build
* {money >= 200} [dual rudder $200]
    ~ turning += 2
    ~ money -= 200
    -> boat_build
* {money >= 300} [thruster $300]
    ~ turning += 3
    ~ money -= 300
    -> boat_build
+[go back] -> boat_build

== special_power ==
* {money >= 400} [nitro boost $400]
    ~ power = "nitro"
    ~ money -= 400
    -> boat_build
* {money >= 400} [spikes $400]
    ~ power = "spikes"
    ~ money -= 400
    -> boat_build
* {money >= 400} [water gun $400]
    ~ power = "gun"
    ~ money -= 400
    -> boat_build
+[go back] -> boat_build

== armor ==
* {money >= 100} [lightweight armor $100]
    ~ strength += 1
    ~ money -= 100
    -> boat_build
* {money >= 300} [heavy armor $300]
    ~ strength += 3
    ~ money -= 300
    -> boat_build
+[go back] -> boat_build

== cosmetics ==
* {money >= 100} [hat $100]
    ~ money -= 100
    -> boat_build
+[go back] -> boat_build

== stats ==
Your speed is {speed}
Your acceleration is {acceleration}
Your turning is {turning}
Your durability is {durability}
Your strength is {strength}
-> race_start

== race_start ==
The day of the race has finally arrived after all your hardwork assembling your boat. They ducks are all lined up at the starting line.
On your mark, get set, go!
{acceleration >= 3 : -> acceleration3}
{acceleration == 2: -> acceleration2}
{acceleration <= 1: -> acceleration1}

== acceleration3 ==
You get off to a great start and are in {place_name()} place
-> race2

== acceleration2 
~ place = 3
You get off to a decent start and are in {place_name()} place
-> race2

== acceleration1
~ place = 5
You get off to a bad start and are in {place_name()} place
-> race2

== race2
The waters are {advance_water()}
* {power == "gun"} [use power] -> gun_use
* [go forward]
{durability >= 4: -> durability1}
{durability == 3: -> durability2}
{durability == 2: -> durability2}
{durability <= 1: -> durability3}

== gun_use
~ place += 1
You use your water cannon to capsize the opponent in front of you and move up to {place_name()} place.
{durability >= 4: -> durability1}
{durability == 3: -> durability2}
{durability == 2: -> durability2}
{durability <= 1: -> durability3}

== durability1 ==
~ place -= 1
The waters don't affect you like they affect the others. You move up to {place_name()} place
-> race3

== durability2 ==
You keep good pace despite the rough waters
-> race3

== durability3 ==
~ place += 2
The rough waters slow you down. You fall back to {place_name()} place
-> race3

== race3
The waters are now {advance_water()} as you enter a straightaway.
* {power == "nitro"} [use power] -> nitro_boost
* [go forward]
{speed >= 6: -> speed1}
{speed == 5: -> speed2}
{speed == 4: -> speed3}
{speed == 3: -> speed4}
{speed <= 2: -> speed4}

== nitro_boost
~place -= 2
Your boat surges forward completely blowing by the rest of the competition, ending up in {place_name()} place
-> race4

== speed1
~ place -= 1
Your speed is overwhelming and you jump up to {place_name()} place
-> race4

== speed2
You're moving fast on the smooth waters and stay at {place_name()} place
-> race4

== speed3
~ place += 1
You go as fast as you can but fall to {place_name()} place
-> race4

== speed4
~ place += 2
Your speed is lackluster and you drop to {place_name()} place
-> race4

== race4
You enter the curviest part of the race while there is a {advance_water()}. It's time to show off your steering ability.
{turning >= 6: -> turning1}
{turning == 5: -> turning2}
{turning == 4: -> turning3}
{turning == 3: -> turning4}
{turning <= 2: -> turning5}

== turning1
~ place -= 2
Your boat is amazing at getting through the narrow parts of the course and goes up to {place_name()} place
-> race5

== turning2
~ place -= 1
Your boat does a good job navigating this area and moves up to {place_name()} place
-> race5

== turning3
You do a good job navigating this area and stay at {place_name()} place
-> race5

== turning4
~place += 1
Your boat is not great at steering and moves back to {place_name()} place
-> race5

== turning5
~ place += 2
Your boat gets stuck in the current and falls back to {place_name()} place
-> race5

== race5
As you get closer to the end the waters are {advance_water()}.
* {power == "spikes"} -> spikes_power
* [go forward]
{strength >= 5: -> str1}
{strength == 4: -> str1}
{strength == 3: -> str2}
{strength == 2: -> str3}
{strength <= 1: -> str4}

== spikes_power ==
~ place -= 1
You are able to get close enough to an opposing boat to shred it with your spikes, moving you up to {place_name()} place.
-> race6

== str1 ==
Despite getting attacked, your armor is strong and you stay in {place_name()} place
-> race6

== str2 ==
~ place += 1
You get attacked and take minor damage, moving back to {place_name()} place
-> race6

== str3 ==
~ place += 2
You get attacked and take serious damage, moving you back to {place_name()} place
-> race6

== str4 ==
~ place += 3
You get attacked and almost capsize, moving you back to {place_name()} place
-> race6

== race6 ==
You can see the finish line. The waters are {advance_water()} and there's a clear shot to the end.
{speed >= 6: -> speed5}
{speed == 5: -> speed6}
{speed == 4: -> speed7}
{speed == 3: -> speed8}
{speed <= 2: -> speed4}

== speed5 ==
~ place -= 2
Your boat goes as fast as it possibly can and you cross the finish line in...
-> finish

== speed6 ==
~ place -= 1
Your boat is zooming towards the finish line and ends up in...
-> finish

== speed7 ==
Your boat finishes with a steady pace and ends up in...
-> finish

== speed8 ==
~ place += 1
Your boat finally finishes and you end up in...
-> finish

== finish ==
{place_name()} place! Congratulations
-> END






