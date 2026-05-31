// Logistic action monitor — every 0.4s it recomputes which scroll-menu options
// should be available for the vehicle the player is LOOKING AT (on foot) or the
// aircraft they are PILOTING. The LOG_*_VALID globals it sets are read by the
// addAction conditions in object/init.sqf, tow/init.sqf and lift/init.sqf.
//
// IMPORTANT: every LOG_*_VALID flag is reset to false at the top of each pass.
// They are persistent globals; if a pass does not overwrite one, a stale "true"
// lingers. That staleness is what previously left the Tow option visible while
// seated inside a liftable helicopter (the lift branch set LOG_OBJECT_ADDACTION
// to the heli while LOG_OBJECT_TRAILER_VALID was still true from looking at it on
// foot). Resetting each pass makes that class of bug impossible.

private [
	"_target","_onFoot","_mb","_disabledT",
	"_towable","_hideList","_hideFlag","_hideDist",
	"_isTug","_istowList","_targTrailer","_targStill",
	"_lifter","_islift","_isLifter","_hp","_vel","_alt"
];

while {true} do {

	// ---- reset state each pass so nothing leaks between iterations ----
	LOG_OBJECT_ADDACTION     = objNull;
	LOG_OBJECT_TRAILER_VALID = false;
	LOG_DETACH_VALID         = false;
	LOG_TRAILER_MOVE_VALID   = false;
	LOG_TRAILER_SELECT_VALID = false;
	LOG_HELI_LIFT_VALID      = false;
	LOG_HELI_DROP_VALID      = false;

	_target = cursorTarget;
	_onFoot = (vehicle player == player);

	if (_onFoot) then {
		// ===================== ON FOOT: looking at a vehicle =====================
		if (!isNull _target && {player distance _target < 13}) then {
			LOG_OBJECT_ADDACTION = _target;
			_mb        = _target getVariable "LOG_moves_by";
			_disabledT = _target getVariable "LOG_disabled";

			// ---- Can the target BE towed? (Tow / Untow options on it) ----
			// Tier only decides the proximity list + hide flag (AIRTUG has precedence).
			_towable  = true;
			_hideList = [];
			_hideFlag = LOG_CFG_HIDE_SCROLL_OPTION;
			_hideDist = LOG_CFG_TOW_DISTANCE;
			if ({_target isKindOf _x} count LOG_CFG_ISTOWABLE_AIRTUG > 0) then {
				_hideList = LOG_CFG_CANTOW_AIRTUG;
				_hideFlag = LOG_CFG_HIDE_SCROLL_OPTION_AIRTUG;
				_hideDist = LOG_CFG_AIRTUG_TOW_DISTANCE;
			} else {
				if ({_target isKindOf _x} count LOG_CFG_ISTOWABLE_TINY > 0) then {
					_hideList = LOG_CFG_CANTOW_TINY + LOG_CFG_CANTOW_SMALL + LOG_CFG_CANTOW_MEDIUM + LOG_CFG_CANTOW_LARGE;
				} else {
					if ({_target isKindOf _x} count LOG_CFG_ISTOWABLE_SMALL > 0) then {
						_hideList = LOG_CFG_CANTOW_SMALL + LOG_CFG_CANTOW_MEDIUM + LOG_CFG_CANTOW_LARGE;
					} else {
						if ({_target isKindOf _x} count LOG_CFG_ISTOWABLE_MEDIUM > 0) then {
							_hideList = LOG_CFG_CANTOW_MEDIUM + LOG_CFG_CANTOW_LARGE;
						} else {
							if ({_target isKindOf _x} count LOG_CFG_ISTOWABLE_LARGE > 0) then {
								_hideList = LOG_CFG_CANTOW_LARGE;
							} else {
								_towable = false;
							};
						};
					};
				};
			};

			if (_towable) then {
				LOG_OBJECT_TRAILER_VALID = (
					(alive _target) && (count crew _target == 0) &&
					isNull LOG_OBJECT_MOVES && isNull _mb &&
					!_disabledT && ([_target] call LOG_FNCT_LOCKED) && ([_target,2] call LOG_FNCT_CHAINING)
				);
				LOG_DETACH_VALID = (isNull LOG_OBJECT_MOVES && !isNull _mb && !_disabledT);
				if (_hideFlag) then {
					LOG_TRAILER_IS_NEAR_TOW_VEHICLE = (count ((nearestObjects [_target, _hideList, _hideDist]) - [_target]) > 0);
				} else {
					LOG_TRAILER_IS_NEAR_TOW_VEHICLE = true;
				};
			};

			// ---- Is the target a tow vehicle / tug? (Select trailer / Untow on it) ----
			// Tier decides which class list the tug is able to tow (AIRTUG precedence).
			_isTug     = true;
			_istowList = [];
			if ({_target isKindOf _x} count LOG_CFG_CANTOW_AIRTUG > 0) then {
				_istowList = LOG_CFG_ISTOWABLE_AIRTUG;
			} else {
				if ({_target isKindOf _x} count LOG_CFG_CANTOW_TINY > 0) then {
					_istowList = LOG_CFG_ISTOWABLE_TINY;
				} else {
					if ({_target isKindOf _x} count LOG_CFG_CANTOW_SMALL > 0) then {
						_istowList = LOG_CFG_ISTOWABLE_SMALL;
					} else {
						if ({_target isKindOf _x} count LOG_CFG_CANTOW_MEDIUM > 0) then {
							_istowList = LOG_CFG_ISTOWABLE_MEDIUM;
						} else {
							if ({_target isKindOf _x} count LOG_CFG_CANTOW_LARGE > 0) then {
								_istowList = LOG_CFG_ISTOWABLE_LARGE;
							} else {
								_isTug = false;
							};
						};
					};
				};
			};

			if (_isTug) then {
				_targTrailer = _target getVariable "LOG_trailer";
				_targStill   = (([0,0,0] distance velocity _target < 6) && (getPos _target select 2 < 2));
				LOG_TRAILER_MOVE_VALID = (
					(alive _target) && !isNull LOG_OBJECT_MOVES && (alive LOG_OBJECT_MOVES) &&
					!(LOG_OBJECT_MOVES getVariable "LOG_disabled") &&
					({LOG_OBJECT_MOVES isKindOf _x} count _istowList > 0) &&
					isNull _targTrailer && _targStill && !_disabledT
				);
				LOG_TRAILER_SELECT_VALID = (
					(alive _target) && isNull LOG_OBJECT_MOVES &&
					!isNull LOG_OBJECT_SELECTION && (LOG_OBJECT_SELECTION != _target) &&
					!(LOG_OBJECT_SELECTION getVariable "LOG_disabled") &&
					({LOG_OBJECT_SELECTION isKindOf _x} count _istowList > 0) &&
					isNull _targTrailer && _targStill && !_disabledT &&
					([_target] call LOG_FNCT_LOCKED) && ([_target,1] call LOG_FNCT_CHAINING)
				);
			};
		};
	} else {
		// ===================== IN A VEHICLE: heli lift / drop =====================
		_lifter   = vehicle player;
		_isLifter = true;
		_islift   = [];
		if ({_lifter isKindOf _x} count LOG_CFG_CANLIFT_TINY > 0) then {
			_islift = LOG_CFG_ISLIFTABLE_TINY;
		} else {
			if ({_lifter isKindOf _x} count LOG_CFG_CANLIFT_SMALL > 0) then {
				_islift = LOG_CFG_ISLIFTABLE_SMALL;
			} else {
				if ({_lifter isKindOf _x} count LOG_CFG_CANLIFT_MEDIUM > 0) then {
					_islift = LOG_CFG_ISLIFTABLE_MEDIUM;
				} else {
					if ({_lifter isKindOf _x} count LOG_CFG_CANLIFT_LARGE > 0) then {
						_islift = LOG_CFG_ISLIFTABLE_LARGE;
					} else {
						_isLifter = false;
					};
				};
			};
		};

		if (_isLifter) then {
			LOG_OBJECT_ADDACTION = _lifter;
			_hp  = _lifter getVariable "LOG_heliporte";
			_vel = ([0,0,0] distance velocity _lifter);
			_alt = (getPos _lifter select 2);
			LOG_HELI_LIFT_VALID = (
				(driver _lifter == player) &&
				({_x != _lifter && !(_x getVariable "LOG_disabled") && ([_x] call LOG_FNCT_LOCKED)} count (nearestObjects [_lifter, _islift, 10]) > 0) &&
				isNull _hp && (_vel < 8) && (_alt > 1) && !(_lifter getVariable "LOG_disabled")
			);
			LOG_HELI_DROP_VALID = (
				(driver _lifter == player) && !isNull _hp &&
				(((_vel <= 10) && (_alt <= 20)) || (_alt >= 50)) && !(_lifter getVariable "LOG_disabled")
			);
		};
	};

	sleep 0.4;
};
