# A2Epoch_Logistic (1.0.7.1+)

LOGISTIC - TOW / LIFT

by Nightmare @ http://n8m4re.de

Based on  R3F_ARTY_LOG by  "madbull ~R3F~" @ http://www.team-r3f.org

A SPECIAL THANKS GOES TO

- SKARONATOR @ http://skaronator.com - for helping me out with the hive write 
- Jeff @ http://casual.fr  - french translation
- Blite - German Translation reworked
- Anarior - Tow reworked	
 


1.)  unpack  "zip" and copy the "logistic" folder to your "/MPMissions/DayZ_Epoch.Map" folder.

2.)  open the "init.sqf" in your mission folder and BELOW:   

`execVM "\z\addons\dayz_code\system\antihack.sqf";`

Add this: `call compile preprocessFileLineNumbers "logistic\init.sqf";`
So that it looks like:
~~~sqf
	// Enables Plant lib fixes
	execVM "\z\addons\dayz_code\system\antihack.sqf";
	call compile preprocessFileLineNumbers "logistic\init.sqf";
~~~

	
	
enjoy  &&  have fun

# Bomb's changes:
- Adds tiers of vehicles by estimated weight such as Large, Medium, Small, and Tiny for Ground and Air vehicles.
- A vehicle can tow anything of it's own size or smaller. So a Large ground vehicle can tow any ground vehicle. A medium vehicle like an SUV can only tow other medium vehicles and smaller.
- A tank can tow any ground vehicle BUT can not be lifted
- A Large helicopter can lift small and tiny helicopters.
- A Large helicopter can lift any ground vehicle, whereas a medium helicopter can only lift medium and smaller.
- The airTug car (classname "TowingTractor" and other tractors) can tow any plane.
- Most boats are considered 'medium' cars
- Adds option to drop lifted vehicles when flying above 50 alt
- If you drop a vehicle above 50 alt, it will get a parachute and smoke grenade attached. "ParachuteBigWest" if large vehicle, otherwise "ParachuteMediumWest"
- ~~Automatically translates for english, german, and french players on a per player  basis. Previously the server developer had to choose one for all players.~~ Adds stringtable for previously supported languages.

## Install notes:
- This guide doesn't cover battleye filters
- Install logistic like normal (instructions above)
If you are using 1.0.7 and **not 1.0.7.1** do the following:
- Install https://github.com/oiad/communityLocalizations if you haven't already.
- Add the entire Logistic package found in the included stringtable.xml below `<Project name="DayZ Community">`

Bomb final note:
I simply made some changes to make it more realistic. Feel free to edit how you like. Also take a look at [These Changes](https://github.com/ZzBombardierzZ/A2Epoch_Logistic/blob/master/logistic/object/init.sqf#L28-L32) which if you uncomment, requires [this repo](https://github.com/oiad/scripts/tree/master/fnc_log). My changes may also cause more lag on the tow system, although I don't notice much, it probably could have been written better.