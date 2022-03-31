# A2Epoch_Logistic

LOGISTIC - TOW / LIFT

by Nightmare @ http://n8m4re.de

Based on  R3F_ARTY_LOG by  "madbull ~R3F~" @ http://www.team-r3f.org

A SPECIAL THANKS GOES TO

- SKARONATOR @ http://skaronator.com - for helping me out with the hive write 
- Jeff @ http://casual.fr  - french translation
- Blite - German Translation reworked
- Anarior - Tow reworked	
 


1.)  unpack  "zip" and copy the "logistic" folder to your "/MPMissions/DayZ_Epoch.Map" folder.

2.)  open the "init.sqf" in your mission folder and add following on the top, after:   

"call compile preprocessFileLineNumbers "server_traders.sqf"; "

THIS====>>   call compile preprocessFileLineNumbers "logistic\init.sqf";   <<<=========
	
	
enjoy  &&  have fun

Bomb changes:
- Adds tiers of vehicles by estimated weight such as Large, Medium, Small, and Tiny for Ground and Air vehicles.
- A vehicle can tow anything of it's own size or smaller. So a Large ground vehicle can tow any ground vehicle. A medium vehicle like an SUV can only tow other medium vehicles and smaller.
- A tank can tow any ground vehicle BUT can not be lifted
- A Large helicopter can lift small and tiny helicopters.
- A Large helicopter can lift any ground vehicle, whereas a medium helicopter can only lift medium and smaller.
- The airTug car (classname "TowingTractor" and other tractors) can tow any plane.
- 

Bomb install notes:
- Install logistic like normal (instructions above)
- Install https://github.com/oiad/communityLocalizations if you haven't already.
- Add the following below `<Project name="DayZ Community">`
```
<Package name="Logistic">
		<Key ID="STR_LOG_CFG_LANG">
            <English>en</English>
            <German>de</German>
            <French>fe</French>
        </Key>
</Package>
```