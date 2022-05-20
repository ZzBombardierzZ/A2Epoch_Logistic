//modified by bomb

if (LOG_INPROGRESS) then{
[localize 'STR_LOG_INPROGRESS',COLOR_ERROR] call SAM_SAYS;
} else {
LOG_INPROGRESS = true;
	private ["_object","_tug"];
	_object = LOG_OBJECT_SELECTION;
	_tug = _this select 0;
	local _continueTowing = true;
	
	if (!(isNull _object) && (alive _object) && !(_object getVariable "LOG_disabled")) then{	
		if (isNull (_object getVariable "LOG_moves_by") && (isNull (_object getVariable "LOG_moves_by") || (!alive (_object getVariable "LOG_moves_by")))) then{
			if ( _object distance _tug <= LOG_CFG_TOW_DISTANCE ) then{

				if (LOG_CFG_REQUIRED_MAGAZINE != "") then {
					//check if we have the required magazine
					if (LOG_CFG_REQUIRED_MAGAZINE in magazines player) then{
						//You have it!
						if (LOG_CFG_CONSUME_MAGAZINE) then {
							//consume the magazine
							player removeMagazine LOG_CFG_REQUIRED_MAGAZINE;
						};
					} else { //You don't have it :(
						[format [localize 'STR_LOG_MISSING_EQUIPMENT', getText(configFile >> "CfgMagazines" >> LOG_CFG_REQUIRED_MAGAZINE >> "displayName")],COLOR_ERROR] call SAM_SAYS;
						_continueTowing = false;
					};
				};

				if (LOG_CFG_REQUIRED_TOOL != "") then {
					//check if we have the required tool/weapon
					if (LOG_CFG_REQUIRED_TOOL in weapons player) then{
						//You have it!
						if (LOG_CFG_CONSUME_TOOL) then {
							//consume the tool/weapon
							player removeWeapon LOG_CFG_REQUIRED_TOOL;
						};
					} else { //You don't have it :(
						[format [localize 'STR_LOG_MISSING_EQUIPMENT', getText(configFile >> "CfgWeapons" >> LOG_CFG_REQUIRED_TOOL >> "displayName")],COLOR_ERROR] call SAM_SAYS;
						_continueTowing = false;
					};
				};

				if (_continueTowing) then {
					_tug setVariable ["LOG_trailer", _object, true];
						
					_object setVariable ["LOG_moves_by", _tug, true];

					//player attachTo [_tug, [ 
					//(boundingBox _tug select 1 select 0),
					//(boundingBox _tug select 0 select 1) + 2, 
					//(boundingBox _tug select 0 select 2) - (boundingBox player select 0 select 2)]];
					sleep 0.2;
					//_object lock true; //added
					
					//player setDir 270;
					//player setPos (getPos player);
					//[player,"repair",0,false,20] call dayz_zombieSpeak;
					player playActionNow "Medic";
					sleep 2;
					
					_object setVelocity [0,0,0];
					_object attachTo [ _tug, [
						0,
						(boundingBox _tug select 0 select 1) + (boundingBox _object select 0 select 1) - 1,
						(boundingBox _tug select 0 select 2) - (boundingBox _object select 0 select 2)
					]];
				
					
					LOG_OBJECT_SELECTION = objNull;
					//detach player;
						
					sleep 3;
					[format [localize 'STR_LOG_ATTACHED', getText (configFile >> "CfgVehicles" >> (typeOf _object) >> "displayName")],COLOR_SUCCESS] call SAM_SAYS;	
				};			
			}else{[format [localize 'STR_LOG_TOO_FAR', getText (configFile >> "CfgVehicles" >> (typeOf _object) >> "displayName")],COLOR_ERROR] call SAM_SAYS;};
		}else{[format [localize 'STR_LOG_IN_TRANSIT', getText (configFile >> "CfgVehicles" >> (typeOf _object) >> "displayName")],COLOR_ERROR] call SAM_SAYS;};
	};
LOG_INPROGRESS = false;
};
