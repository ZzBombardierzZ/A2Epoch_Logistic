private ["_target"];
while {true} do{

	LOG_OBJECT_ADDACTION = objNull;
	_target = cursorTarget;
	
	if ( !(isNull _target) && ( player distance _target < 13 ) ) then{
		LOG_OBJECT_ADDACTION = _target;
		
		if ({_target isKindOf _x} count LOG_CFG_ISTOWABLE_TINY > 0) then {
			LOG_OBJECT_TRAILER_VALID = (vehicle player == player && (alive _target) && (count crew _target == 0) &&
			isNull LOG_OBJECT_MOVES && isNull (_target getVariable "LOG_moves_by") &&
			(isNull (_target getVariable "LOG_moves_by") || (!alive (_target getVariable "LOG_moves_by"))) &&
			!(_target getVariable "LOG_disabled") && ( [_target] call LOG_FNCT_LOCKED ) && ( [_target,2] call LOG_FNCT_CHAINING ) );

			if (LOG_CFG_HIDE_SCROLL_OPTION) then {
				LOG_TRAILER_IS_NEAR_TOW_VEHICLE = false;
				if (count (nearestObjects [_target,LOG_CFG_CANTOW_TINY+LOG_CFG_CANTOW_SMALL+LOG_CFG_CANTOW_MEDIUM+LOG_CFG_CANTOW_LARGE,LOG_CFG_TOW_DISTANCE] - [_target]) > 0) then {
					LOG_TRAILER_IS_NEAR_TOW_VEHICLE = true;
				};
			};
			
			LOG_DETACH_VALID = ( vehicle player == player && (isNull LOG_OBJECT_MOVES) && !isNull (_target getVariable "LOG_moves_by") && !(_target getVariable "LOG_disabled") );
		} else {
			if ({_target isKindOf _x} count LOG_CFG_ISTOWABLE_SMALL > 0) then {
				LOG_OBJECT_TRAILER_VALID = (vehicle player == player && (alive _target) && (count crew _target == 0) &&
				isNull LOG_OBJECT_MOVES && isNull (_target getVariable "LOG_moves_by") &&
				(isNull (_target getVariable "LOG_moves_by") || (!alive (_target getVariable "LOG_moves_by"))) &&
				!(_target getVariable "LOG_disabled") && ( [_target] call LOG_FNCT_LOCKED ) && ( [_target,2] call LOG_FNCT_CHAINING ) );
				
				if (LOG_CFG_HIDE_SCROLL_OPTION) then {
					LOG_TRAILER_IS_NEAR_TOW_VEHICLE = false;
					if (count (nearestObjects [_target,LOG_CFG_CANTOW_SMALL+LOG_CFG_CANTOW_MEDIUM+LOG_CFG_CANTOW_LARGE,LOG_CFG_TOW_DISTANCE] - [_target]) > 0) then {
						LOG_TRAILER_IS_NEAR_TOW_VEHICLE = true;
					};
				};

				LOG_DETACH_VALID = ( vehicle player == player && (isNull LOG_OBJECT_MOVES) && !isNull (_target getVariable "LOG_moves_by") && !(_target getVariable "LOG_disabled") );
			} else {
				if ({_target isKindOf _x} count LOG_CFG_ISTOWABLE_MEDIUM > 0) then {
					LOG_OBJECT_TRAILER_VALID = (vehicle player == player && (alive _target) && (count crew _target == 0) &&
					isNull LOG_OBJECT_MOVES && isNull (_target getVariable "LOG_moves_by") &&
					(isNull (_target getVariable "LOG_moves_by") || (!alive (_target getVariable "LOG_moves_by"))) &&
					!(_target getVariable "LOG_disabled") && ( [_target] call LOG_FNCT_LOCKED ) && ( [_target,2] call LOG_FNCT_CHAINING ) );

					if (LOG_CFG_HIDE_SCROLL_OPTION) then {
						LOG_TRAILER_IS_NEAR_TOW_VEHICLE = false;
						if (count (nearestObjects [_target,LOG_CFG_CANTOW_MEDIUM+LOG_CFG_CANTOW_LARGE,LOG_CFG_TOW_DISTANCE] - [_target]) > 0) then {
							LOG_TRAILER_IS_NEAR_TOW_VEHICLE = true;
						};
					};
					
					LOG_DETACH_VALID = ( vehicle player == player && (isNull LOG_OBJECT_MOVES) && !isNull (_target getVariable "LOG_moves_by") && !(_target getVariable "LOG_disabled") );
				} else {
					if ({_target isKindOf _x} count LOG_CFG_ISTOWABLE_LARGE > 0) then {
						LOG_OBJECT_TRAILER_VALID = (vehicle player == player && (alive _target) && (count crew _target == 0) &&
						isNull LOG_OBJECT_MOVES && isNull (_target getVariable "LOG_moves_by") &&
						(isNull (_target getVariable "LOG_moves_by") || (!alive (_target getVariable "LOG_moves_by"))) &&
						!(_target getVariable "LOG_disabled") && ( [_target] call LOG_FNCT_LOCKED ) && ( [_target,2] call LOG_FNCT_CHAINING ) );

						if (LOG_CFG_HIDE_SCROLL_OPTION) then {
							LOG_TRAILER_IS_NEAR_TOW_VEHICLE = false;
							if (count (nearestObjects [_target,LOG_CFG_CANTOW_LARGE,LOG_CFG_TOW_DISTANCE] - [_target]) > 0) then {
								LOG_TRAILER_IS_NEAR_TOW_VEHICLE = true;
							};
						};
						
						LOG_DETACH_VALID = ( vehicle player == player && (isNull LOG_OBJECT_MOVES) && !isNull (_target getVariable "LOG_moves_by") && !(_target getVariable "LOG_disabled") );
					};
				};
			};
		};
		if ({_target isKindOf _x} count LOG_CFG_ISTOWABLE_AIRTUG > 0) then {
			LOG_OBJECT_TRAILER_VALID = (vehicle player == player && (alive _target) && (count crew _target == 0) &&
			isNull LOG_OBJECT_MOVES && isNull (_target getVariable "LOG_moves_by") &&
			(isNull (_target getVariable "LOG_moves_by") || (!alive (_target getVariable "LOG_moves_by"))) &&
			!(_target getVariable "LOG_disabled") && ( [_target] call LOG_FNCT_LOCKED ) && ( [_target,2] call LOG_FNCT_CHAINING ) );

			if (LOG_CFG_HIDE_SCROLL_OPTION_AIRTUG) then {
				LOG_TRAILER_IS_NEAR_TOW_VEHICLE = false;
				if (count (nearestObjects [_target,LOG_CFG_CANTOW_AIRTUG,LOG_CFG_AIRTUG_TOW_DISTANCE] - [_target]) > 0) then {
					LOG_TRAILER_IS_NEAR_TOW_VEHICLE = true;
				};
			};
			
			LOG_DETACH_VALID = ( vehicle player == player && (isNull LOG_OBJECT_MOVES) && !isNull (_target getVariable "LOG_moves_by") && !(_target getVariable "LOG_disabled") );
		};
		
		
		if ({_target isKindOf _x} count LOG_CFG_CANTOW_TINY > 0) then {

			LOG_TRAILER_MOVE_VALID = (vehicle player == player && (alive _target) && (!isNull LOG_OBJECT_MOVES) &&
			(alive LOG_OBJECT_MOVES) && !(LOG_OBJECT_MOVES getVariable "LOG_disabled") &&
			({LOG_OBJECT_MOVES isKindOf _x} count LOG_CFG_ISTOWABLE_TINY > 0) &&
			isNull (_target getVariable "LOG_trailer") && ([0,0,0] distance velocity _target < 6) &&
			(getPos _target select 2 < 2) && !(_target getVariable "LOG_disabled"));
			
			LOG_TRAILER_SELECT_VALID = ( vehicle player == player && (alive _target) && (isNull LOG_OBJECT_MOVES) &&
			(!isNull LOG_OBJECT_SELECTION) && (LOG_OBJECT_SELECTION != _target) &&
			!(LOG_OBJECT_SELECTION getVariable "LOG_disabled") &&
			({LOG_OBJECT_SELECTION isKindOf _x} count LOG_CFG_ISTOWABLE_TINY > 0) &&
			isNull (_target getVariable "LOG_trailer") && ([0,0,0] distance velocity _target < 6) &&
			(getPos _target select 2 < 2) && !(_target getVariable "LOG_disabled")  && ( [_target] call LOG_FNCT_LOCKED ) && ( [ _target,1] call LOG_FNCT_CHAINING ) );
		} else {
			if ({_target isKindOf _x} count LOG_CFG_CANTOW_SMALL > 0) then {

				LOG_TRAILER_MOVE_VALID = (vehicle player == player && (alive _target) && (!isNull LOG_OBJECT_MOVES) &&
				(alive LOG_OBJECT_MOVES) && !(LOG_OBJECT_MOVES getVariable "LOG_disabled") &&
				({LOG_OBJECT_MOVES isKindOf _x} count LOG_CFG_ISTOWABLE_SMALL > 0) &&
				isNull (_target getVariable "LOG_trailer") && ([0,0,0] distance velocity _target < 6) &&
				(getPos _target select 2 < 2) && !(_target getVariable "LOG_disabled"));
				
				LOG_TRAILER_SELECT_VALID = ( vehicle player == player && (alive _target) && (isNull LOG_OBJECT_MOVES) &&
				(!isNull LOG_OBJECT_SELECTION) && (LOG_OBJECT_SELECTION != _target) &&
				!(LOG_OBJECT_SELECTION getVariable "LOG_disabled") &&
				({LOG_OBJECT_SELECTION isKindOf _x} count LOG_CFG_ISTOWABLE_SMALL > 0) &&
				isNull (_target getVariable "LOG_trailer") && ([0,0,0] distance velocity _target < 6) &&
				(getPos _target select 2 < 2) && !(_target getVariable "LOG_disabled")  && ( [_target] call LOG_FNCT_LOCKED ) && ( [ _target,1] call LOG_FNCT_CHAINING ) );
			} else {
				if ({_target isKindOf _x} count LOG_CFG_CANTOW_MEDIUM > 0) then {

					LOG_TRAILER_MOVE_VALID = (vehicle player == player && (alive _target) && (!isNull LOG_OBJECT_MOVES) &&
					(alive LOG_OBJECT_MOVES) && !(LOG_OBJECT_MOVES getVariable "LOG_disabled") &&
					({LOG_OBJECT_MOVES isKindOf _x} count LOG_CFG_ISTOWABLE_MEDIUM > 0) &&
					isNull (_target getVariable "LOG_trailer") && ([0,0,0] distance velocity _target < 6) &&
					(getPos _target select 2 < 2) && !(_target getVariable "LOG_disabled"));
					
					LOG_TRAILER_SELECT_VALID = ( vehicle player == player && (alive _target) && (isNull LOG_OBJECT_MOVES) &&
					(!isNull LOG_OBJECT_SELECTION) && (LOG_OBJECT_SELECTION != _target) &&
					!(LOG_OBJECT_SELECTION getVariable "LOG_disabled") &&
					({LOG_OBJECT_SELECTION isKindOf _x} count LOG_CFG_ISTOWABLE_MEDIUM > 0) &&
					isNull (_target getVariable "LOG_trailer") && ([0,0,0] distance velocity _target < 6) &&
					(getPos _target select 2 < 2) && !(_target getVariable "LOG_disabled")  && ( [_target] call LOG_FNCT_LOCKED ) && ( [ _target,1] call LOG_FNCT_CHAINING ) );
				} else {
					if ({_target isKindOf _x} count LOG_CFG_CANTOW_LARGE > 0) then {

						LOG_TRAILER_MOVE_VALID = (vehicle player == player && (alive _target) && (!isNull LOG_OBJECT_MOVES) &&
						(alive LOG_OBJECT_MOVES) && !(LOG_OBJECT_MOVES getVariable "LOG_disabled") &&
						({LOG_OBJECT_MOVES isKindOf _x} count LOG_CFG_ISTOWABLE_LARGE > 0) &&
						isNull (_target getVariable "LOG_trailer") && ([0,0,0] distance velocity _target < 6) &&
						(getPos _target select 2 < 2) && !(_target getVariable "LOG_disabled"));
						
						LOG_TRAILER_SELECT_VALID = ( vehicle player == player && (alive _target) && (isNull LOG_OBJECT_MOVES) &&
						(!isNull LOG_OBJECT_SELECTION) && (LOG_OBJECT_SELECTION != _target) &&
						!(LOG_OBJECT_SELECTION getVariable "LOG_disabled") &&
						({LOG_OBJECT_SELECTION isKindOf _x} count LOG_CFG_ISTOWABLE_LARGE > 0) &&
						isNull (_target getVariable "LOG_trailer") && ([0,0,0] distance velocity _target < 6) &&
						(getPos _target select 2 < 2) && !(_target getVariable "LOG_disabled")  && ( [_target] call LOG_FNCT_LOCKED ) && ( [ _target,1] call LOG_FNCT_CHAINING ) );
					};
				};
			};
		};
	};
	if ({_target isKindOf _x} count LOG_CFG_CANTOW_AIRTUG > 0) then {

		LOG_TRAILER_MOVE_VALID = (vehicle player == player && (alive _target) && (!isNull LOG_OBJECT_MOVES) &&
		(alive LOG_OBJECT_MOVES) && !(LOG_OBJECT_MOVES getVariable "LOG_disabled") &&
		({LOG_OBJECT_MOVES isKindOf _x} count LOG_CFG_ISTOWABLE_AIRTUG > 0) &&
		isNull (_target getVariable "LOG_trailer") && ([0,0,0] distance velocity _target < 6) &&
		(getPos _target select 2 < 2) && !(_target getVariable "LOG_disabled"));
		
		LOG_TRAILER_SELECT_VALID = ( vehicle player == player && (alive _target) && (isNull LOG_OBJECT_MOVES) &&
		(!isNull LOG_OBJECT_SELECTION) && (LOG_OBJECT_SELECTION != _target) &&
		!(LOG_OBJECT_SELECTION getVariable "LOG_disabled") &&
		({LOG_OBJECT_SELECTION isKindOf _x} count LOG_CFG_ISTOWABLE_AIRTUG > 0) &&
		isNull (_target getVariable "LOG_trailer") && ([0,0,0] distance velocity _target < 6) &&
		(getPos _target select 2 < 2) && !(_target getVariable "LOG_disabled")  && ( [_target] call LOG_FNCT_LOCKED ) && ( [ _target,1] call LOG_FNCT_CHAINING ) );
	};
	
	if ({(vehicle player) isKindOf _x} count LOG_CFG_CANLIFT_TINY > 0) then{
		LOG_OBJECT_ADDACTION = vehicle player;
		LOG_TRAILER_MOVE_VALID = false;
		LOG_TRAILER_SELECT_VALID = false;
		
		LOG_HELI_LIFT_VALID = (driver LOG_OBJECT_ADDACTION == player &&
		({_x != LOG_OBJECT_ADDACTION && !(_x getVariable "LOG_disabled") &&  [_x] call LOG_FNCT_LOCKED  } count (nearestObjects [LOG_OBJECT_ADDACTION, LOG_CFG_ISLIFTABLE_TINY, 10]) > 0) &&
		isNull (LOG_OBJECT_ADDACTION getVariable "LOG_heliporte") && ([0,0,0] distance velocity LOG_OBJECT_ADDACTION < 8 ) && (getPos LOG_OBJECT_ADDACTION select 2 > 1) &&
		!(LOG_OBJECT_ADDACTION getVariable "LOG_disabled"));
		
		LOG_HELI_DROP_VALID = (driver LOG_OBJECT_ADDACTION == player && !isNull (LOG_OBJECT_ADDACTION getVariable "LOG_heliporte") &&
		(([0,0,0] distance velocity LOG_OBJECT_ADDACTION <= 10 && getPos LOG_OBJECT_ADDACTION select 2 <= 20) || getPos LOG_OBJECT_ADDACTION select 2 >= 50) && !(LOG_OBJECT_ADDACTION getVariable "LOG_disabled"));
	} else {
		if ({(vehicle player) isKindOf _x} count LOG_CFG_CANLIFT_SMALL > 0) then{
			LOG_OBJECT_ADDACTION = vehicle player;
			LOG_TRAILER_MOVE_VALID = false;
			LOG_TRAILER_SELECT_VALID = false;
			
			LOG_HELI_LIFT_VALID = (driver LOG_OBJECT_ADDACTION == player &&
			({_x != LOG_OBJECT_ADDACTION && !(_x getVariable "LOG_disabled") &&  [_x] call LOG_FNCT_LOCKED  } count (nearestObjects [LOG_OBJECT_ADDACTION, LOG_CFG_ISLIFTABLE_SMALL, 10]) > 0) &&
			isNull (LOG_OBJECT_ADDACTION getVariable "LOG_heliporte") && ([0,0,0] distance velocity LOG_OBJECT_ADDACTION < 8 ) && (getPos LOG_OBJECT_ADDACTION select 2 > 1) &&
			!(LOG_OBJECT_ADDACTION getVariable "LOG_disabled"));
			
			LOG_HELI_DROP_VALID = (driver LOG_OBJECT_ADDACTION == player && !isNull (LOG_OBJECT_ADDACTION getVariable "LOG_heliporte") &&
			(([0,0,0] distance velocity LOG_OBJECT_ADDACTION <= 10 && getPos LOG_OBJECT_ADDACTION select 2 <= 20) || getPos LOG_OBJECT_ADDACTION select 2 >= 50) && !(LOG_OBJECT_ADDACTION getVariable "LOG_disabled"));
		} else {
			if ({(vehicle player) isKindOf _x} count LOG_CFG_CANLIFT_MEDIUM > 0) then{
				LOG_OBJECT_ADDACTION = vehicle player;
				LOG_TRAILER_MOVE_VALID = false;
				LOG_TRAILER_SELECT_VALID = false;
				
				LOG_HELI_LIFT_VALID = (driver LOG_OBJECT_ADDACTION == player &&
				({_x != LOG_OBJECT_ADDACTION && !(_x getVariable "LOG_disabled") &&  [_x] call LOG_FNCT_LOCKED  } count (nearestObjects [LOG_OBJECT_ADDACTION, LOG_CFG_ISLIFTABLE_MEDIUM, 10]) > 0) &&
				isNull (LOG_OBJECT_ADDACTION getVariable "LOG_heliporte") && ([0,0,0] distance velocity LOG_OBJECT_ADDACTION < 8 ) && (getPos LOG_OBJECT_ADDACTION select 2 > 1) &&
				!(LOG_OBJECT_ADDACTION getVariable "LOG_disabled"));
				
				LOG_HELI_DROP_VALID = (driver LOG_OBJECT_ADDACTION == player && !isNull (LOG_OBJECT_ADDACTION getVariable "LOG_heliporte") &&
				(([0,0,0] distance velocity LOG_OBJECT_ADDACTION <= 10 && getPos LOG_OBJECT_ADDACTION select 2 <= 20) || getPos LOG_OBJECT_ADDACTION select 2 >= 50) && !(LOG_OBJECT_ADDACTION getVariable "LOG_disabled"));
			} else {
				if ({(vehicle player) isKindOf _x} count LOG_CFG_CANLIFT_LARGE > 0) then{
					LOG_OBJECT_ADDACTION = vehicle player;
					LOG_TRAILER_MOVE_VALID = false;
					LOG_TRAILER_SELECT_VALID = false;
					
					LOG_HELI_LIFT_VALID = (driver LOG_OBJECT_ADDACTION == player &&
					({_x != LOG_OBJECT_ADDACTION && !(_x getVariable "LOG_disabled") &&  [_x] call LOG_FNCT_LOCKED  } count (nearestObjects [LOG_OBJECT_ADDACTION, LOG_CFG_ISLIFTABLE_LARGE, 10]) > 0) &&
					isNull (LOG_OBJECT_ADDACTION getVariable "LOG_heliporte") && ([0,0,0] distance velocity LOG_OBJECT_ADDACTION < 8 ) && (getPos LOG_OBJECT_ADDACTION select 2 > 1) &&
					!(LOG_OBJECT_ADDACTION getVariable "LOG_disabled"));
					
					LOG_HELI_DROP_VALID = (driver LOG_OBJECT_ADDACTION == player && !isNull (LOG_OBJECT_ADDACTION getVariable "LOG_heliporte") &&
					(([0,0,0] distance velocity LOG_OBJECT_ADDACTION <= 10 && getPos LOG_OBJECT_ADDACTION select 2 <= 20) || getPos LOG_OBJECT_ADDACTION select 2 >= 50) && !(LOG_OBJECT_ADDACTION getVariable "LOG_disabled"));
				};
			};
		};
	};
	
	sleep 0.4;
};