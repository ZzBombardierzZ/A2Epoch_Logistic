if (LOG_INPROGRESS) then{
	[localize 'STR_LOG_INPROGRESS',COLOR_ERROR] call SAM_SAYS;
}else{
LOG_INPROGRESS = true;
	private ["_carrier","_object"];
	_carrier = _this select 0;
	_object = _carrier getVariable "LOG_heliporte";
	_carrier setVariable ["LOG_heliporte", objNull, true];
	_object setVariable ["LOG_moves_by", objNull, true];
	[_object,_carrier] call LOG_FNCT_DETACH_AND_SAVE_AIR;
	[format [localize 'STR_LOG_DROPPED', getText (configFile >> "CfgVehicles" >> (typeOf _object) >> "displayName")],COLOR_SUCCESS] call SAM_SAYS;
LOG_INPROGRESS = false;
};
