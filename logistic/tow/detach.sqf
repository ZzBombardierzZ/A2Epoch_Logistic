//modified by bomb

if (LOG_INPROGRESS) then {
[localize 'STR_LOG_INPROGRESS',COLOR_ERROR] call SAM_SAYS;
} else{
LOG_INPROGRESS = true;
	private ["_tug","_object"];
	_object = _this select 0;
	_tug = _object getVariable "LOG_moves_by";
	if ({_tug isKindOf _x} count LOG_CFG_CANTOW_TINY > 0 || {_tug isKindOf _x} count LOG_CFG_CANTOW_SMALL > 0 || {_tug isKindOf _x} count LOG_CFG_CANTOW_MEDIUM > 0 ||
	{_tug isKindOf _x} count LOG_CFG_CANTOW_LARGE > 0 || {_tug isKindOf _x} count LOG_CFG_CANTOW_AIRTUG > 0) then{
		_tug setVariable ["LOG_trailer", objNull, true];
		_object setVariable ["LOG_moves_by", objNull, true];
		[_object] call LOG_FNCT_DETACH_AND_SAVE;
		sleep 3;
		//_object lock false; //added
		//_object setVehicleLock "unlocked"; //added to fix mission vehicles?
		[format [localize 'STR_LOG_UNTOWED', getText (configFile >> "CfgVehicles" >> (typeOf _object) >> "displayName")],COLOR_SUCCESS] call SAM_SAYS;
		if (LOG_CFG_CONSUME_MAGAZINE && LOG_CFG_RETURN_MAGAZINE && LOG_CFG_REQUIRED_MAGAZINE != "") then {
			//add magazine back to player inventory
			player addMagazine LOG_CFG_REQUIRED_MAGAZINE;
			systemchat format [localize 'STR_LOG_RETURNED_EQUIPMENT', getText(configFile >> "CfgMagazines" >> LOG_CFG_REQUIRED_MAGAZINE >> "displayName")];
		};
		if (LOG_CFG_CONSUME_TOOL && LOG_CFG_RETURN_TOOL && LOG_CFG_REQUIRED_TOOL != "") then {
			//add weapon/tool back to player inventory
			player addWeapon LOG_CFG_REQUIRED_TOOL;
			systemchat format [localize 'STR_LOG_RETURNED_EQUIPMENT', getText(configFile >> "CfgWeapons" >> LOG_CFG_REQUIRED_TOOL >> "displayName")];
		};
	}else{[localize 'STR_LOG_IMPOSSIBLE_VEHICLE',COLOR_ERROR] call SAM_SAYS;};
LOG_INPROGRESS = false;
};
