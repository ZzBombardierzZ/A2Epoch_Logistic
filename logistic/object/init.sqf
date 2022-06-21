//modified by bomb

private ["_object","_moves_by","_trailer","_disabled","_message"];
_object = _this select 0;
_disabled = _object getVariable "LOG_disabled";

if (isNil "_disabled") then{_object setVariable ["LOG_disabled", false];};

//_trailer = _object getVariable "LOG_trailer";
//if (isNil "_trailer") then{_object setVariable ["LOG_trailer", objNull, false];};

_moves_by = _object getVariable "LOG_moves_by";
if (isNil "_moves_by") then{_object setVariable ["LOG_moves_by", objNull, false];};

if !(LOG_CFG_ALLOW_GETIN) then {
	_object addEventHandler ["GetIn",{
		if (_this select 2 == player) then{
			_this spawn{
				private ["_eject"];
				_eject = false;
				if ((!(isNull (_this select 0 getVariable "LOG_moves_by")) && (alive (_this select 0 getVariable "LOG_moves_by")))) then { _eject = true;};
				if ((!(isNull (_this select 0 getVariable "LOG_heliporte")) && (alive (_this select 0 getVariable "LOG_heliporte")))) then { _eject = true;};
				if (_eject) then{ 
					player action ["eject", _this select 0]; 
					systemChat "YOU ARE NOT ALLOWED IN A VEHICLE BEING TOWED!"; //added by bomb
					systemChat "REPORTING YOU TO ADMINS IN CASE OF GLITCHING."; //added by bomb
					titleText [format["Do not get in vehicles being towed! You have been warned."],"PLAIN DOWN"]; titleFadeOut 10; //added
					//_message = format ["%1 (%2) ATTEMPTED TO GET IN TOWED VEHICLE @ %3 (%6). NearBy Players: %4  NearBy Plot: %5",dayz_playerName,dayz_playerUID,(mapGridPosition getPos player),([player,300] call fnc_nearBy),(player call fnc_nearPlot), getPos player]; //added by bomb
					//diag_log _message; //added by bomb
					//["towGlitcher",_message] call fnc_Log; //added by bomb
					//playSound "alarmNoise"; //added by bomb
				};
			};
		};
	}];
};

//modified by bomb
/*
if ({_object isKindOf _x} count LOG_CFG_ISTOWABLE_TINY > 0) then{
	_object addAction [("<t color='#dddd00'>" + localize 'STR_LOG_TOW' + "</t>"),"logistic\object\isSelected.sqf",[],5,false,true,"","LOG_OBJECT_ADDACTION == _target && LOG_OBJECT_TRAILER_VALID"];
	_object addAction [("<t color='#dddd00'>" + localize 'STR_LOG_UNTOW' + "</t>"),"logistic\tow\detach.sqf",[],6,true,true,"","LOG_OBJECT_ADDACTION == _target && LOG_DETACH_VALID"];
};
if ({_object isKindOf _x} count LOG_CFG_ISTOWABLE_SMALL > 0) then{
	_object addAction [("<t color='#dddd00'>" + localize 'STR_LOG_TOW' + "</t>"),"logistic\object\isSelected.sqf",[],5,false,true,"","LOG_OBJECT_ADDACTION == _target && LOG_OBJECT_TRAILER_VALID"];
	_object addAction [("<t color='#dddd00'>" + localize 'STR_LOG_UNTOW' + "</t>"),"logistic\tow\detach.sqf",[],6,true,true,"","LOG_OBJECT_ADDACTION == _target && LOG_DETACH_VALID"];
};
if ({_object isKindOf _x} count LOG_CFG_ISTOWABLE_MEDIUM > 0) then{
	_object addAction [("<t color='#dddd00'>" + localize 'STR_LOG_TOW' + "</t>"),"logistic\object\isSelected.sqf",[],5,false,true,"","LOG_OBJECT_ADDACTION == _target && LOG_OBJECT_TRAILER_VALID"];
	_object addAction [("<t color='#dddd00'>" + localize 'STR_LOG_UNTOW' + "</t>"),"logistic\tow\detach.sqf",[],6,true,true,"","LOG_OBJECT_ADDACTION == _target && LOG_DETACH_VALID"];
};*/
if ({_object isKindOf _x} count LOG_CFG_ISTOWABLE_LARGE > 0) then{
	_object addAction [("<t color='#dddd00'>" + localize 'STR_LOG_TOW' + "</t>"),"logistic\object\isSelected.sqf",[],5,false,true,"","LOG_OBJECT_ADDACTION == _target && LOG_OBJECT_TRAILER_VALID && LOG_TRAILER_IS_NEAR_TOW_VEHICLE"];
	_object addAction [("<t color='#dddd00'>" + localize 'STR_LOG_UNTOW' + "</t>"),"logistic\tow\detach.sqf",[],6,true,true,"","LOG_OBJECT_ADDACTION == _target && LOG_DETACH_VALID"];
};
if ({_object isKindOf _x} count LOG_CFG_ISTOWABLE_AIRTUG > 0) then{
	_object addAction [("<t color='#dddd00'>" + localize 'STR_LOG_TOW' + "</t>"),"logistic\object\isSelected.sqf",[],5,false,true,"","LOG_OBJECT_ADDACTION == _target && LOG_OBJECT_TRAILER_VALID && LOG_TRAILER_IS_NEAR_TOW_VEHICLE"];
	_object addAction [("<t color='#dddd00'>" + localize 'STR_LOG_UNTOW' + "</t>"),"logistic\tow\detach.sqf",[],6,true,true,"","LOG_OBJECT_ADDACTION == _target && LOG_DETACH_VALID"];
};