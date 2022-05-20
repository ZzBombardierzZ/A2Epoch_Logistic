if (!isDedicated) then {

	call compile preprocessFileLineNumbers "logistic\config.sqf";

	MONI_OBJECT	= compile preprocessFileLineNumbers "logistic\monitor\monitor_object.sqf";
	MONI_ACTION	= compile preprocessFileLineNumbers "logistic\monitor\monitor_action.sqf";
	LOG_OBJ_INIT = compile preprocessFileLineNumbers "logistic\object\init.sqf";
	LOG_LIFT_INIT = compile preprocessFileLineNumbers "logistic\lift\init.sqf";
	LOG_TOW_INIT = compile preprocessFileLineNumbers "logistic\tow\init.sqf";
	
	LOG_FNCT_DETACH_AND_SAVE = {
		private ["_object"]; 
		_object = (_this select 0);
		_object setVelocity [0,0,0];
		detach _object;
		PVDZ_veh_Save = [_object,"position",true];
		if (isServer) then {
			PVDZ_veh_Save call server_updateObject;
		} else {
			publicVariableServer "PVDZ_veh_Save";
		};
		["Working",0,[20,40,15,0]] call dayz_NutritionSystem;
		player playActionNow "Medic";
		[player,"repair",0,false,20] call dayz_zombieSpeak;
		[player,20,true,(getPosATL player)] spawn player_alertZombies;
		diag_log format [localize 'STR_LOG_UNTOWED', typeOf _object];
	};
	
	//added by bomb
	LOG_FNCT_DETACH_AND_SAVE_AIR = {
		private ["_object","_carrier","_vel"]; 
		_object = (_this select 0);
		_carrier = vehicle player;
		_vel =  velocity _carrier;
		detach _object;
		_object setVelocity _vel;
		if (({_object isKindOf _x} count LOG_CFG_CANTOW_LARGE > 0)) then {
			[_carrier, _object, "ParachuteBigWest"] spawn BTC_paradrop;
		} else {
			//if (({_object isKindOf _x} count LOG_CFG_CANTOW_MEDIUM > 0) || ({_object isKindOf _x} count LOG_CFG_CANLIFT_SMALL > 0) || ({_object isKindOf _x} count LOG_CFG_CANLIFT_TINY > 0)) then {
			[_carrier, _object, "ParachuteMediumWest"] spawn BTC_paradrop;
			//} else {
				//[_carrier, _object, "ParachuteWest"] spawn BTC_paradrop;
			//};
		};
		
		diag_log format [localize 'STR_LOG_UNTOWED', typeOf _object];
	};

	LOG_FNCT_LOCKED = { 
		private ["_return","_target"]; 
		_target = (_this select 0);
		_return = true; 
		if ( !(LOG_CFG_ALLOW_LOCKED) && (locked _target) ) then { 
			_return = false; 
		};
		_return
	};
	
	LOG_FNCT_CHAINING = { 
		private ["_return","_target"];
		_target = (_this select 0);
		_return = true; 
		if !(LOG_CFG_ALLOW_CHAINING) then  { 
			if ( ( (_this select 1) == 1 ) && !( isNull (_target getVariable "LOG_moves_by") || (!alive (_target getVariable "LOG_moves_by")) ) ) then {_return = false;};	
			if ( (_this select 1) == 2 && !isNull (_target getVariable "LOG_trailer") ) then { _return = false;};
		};
		_return 
	};
	
	LOG_FNCT_GETPOS = {
		private "_pos";
		if (isNil {_this select 0}) exitWith {[0,0,0]};
		_thingy = _this select 0;
		_pos = getPosASL _thingy;
		if !(surfaceIsWater _pos) then { _pos =  ASLToATL _pos;};
		_pos
	};
	
	LOG_OBJECT_MOVES = objNull;
	LOG_OBJECT_SELECTION = objNull;
	LOG_OBJECT_ADDACTION = objNull;
	LOG_INPROGRESS = false;
	LOG_LOAD_MOVES_VALID = false;
	LOG_LOAD_SELECTION_VALID = false;
	LOG_CONTENT_VALID = false;
	LOG_TRAILER_MOVE_VALID = false;
	LOG_TRAILER_SELECT_VALID = false;
	LOG_HELI_LIFT_VALID = false;
	LOG_HELI_DROP_VALID = false;
	LOG_OBJECT_TRAILER_VALID = false;
	LOG_DETACH_VALID = false;

	if (LOG_CFG_HIDE_SCROLL_OPTION) then {
		LOG_TRAILER_IS_NEAR_TOW_VEHICLE = false;
	} else {
		LOG_TRAILER_IS_NEAR_TOW_VEHICLE = true;
	};

	
	COLOR_DEFAULT = [(51/255),(181/255),(229/255),1];
	COLOR_SUCCESS = [(153/255),(204/255),0,1];
	COLOR_ERROR  = [1,(68/255),(68/255),1];
	
	SAM_SAYS = { 
		private ["_message","_color"];
		_message = _this select 0;
		_color = _this select 1;
		taskHint [format[_message], _color, "taskNew"];
		_message call dayz_rollingMessages;
	};
	
	//taken from BTC_logistic
	//modified by bomb
	BTC_paradrop =
	{
		private ["_chopper","_cargo","_chute_type","_height","_smoke","_chute","_flare"];

		_chopper          = _this select 0;
		_cargo      = _this select 1;
		_chute_type   = _this select 2;
		_chute = 0;
		
		_height = [_chopper, _cargo] call BTC_getHeight;
		
		diag_log format ["DEBUG BTC LIFT: Paradrop height: %1", _height];
		
		if (_height > 45) then {
			//if (typeOf _chopper == "MH6J_DZ") then {
			if (({_chopper isKindOf _x} count LOG_CFG_CANLIFT_SMALL > 0) || ({_chopper isKindOf _x} count LOG_CFG_CANLIFT_TINY > 0)) then {
				_chute = createVehicle [_chute_type, [((position _chopper) select 0) - 5,((position _chopper) select 1) - 10,((position _chopper) select 2)- 4], [], 0, "NONE"];
			} else {
				_chute = createVehicle [_chute_type, [((position _chopper) select 0) - 5,((position _chopper) select 1) - 5,((position _chopper) select 2)- 4], [], 0, "NONE"];
			};
			_smoke        = "SmokeshellGreen" createVehicle position _chopper;
			_flare        = "F_40mm_Green" createVehicle position _chopper;
			_smoke attachto [_cargo, [0,0,0]]; 
			_flare attachto [_cargo, [0,0,0]];
			_cargo attachTo [_chute, [0,0,0]];
			while {_height > 4} do {
				sleep 0.1;
				_height = [_chopper, _cargo] call BTC_getHeight;
			};
			sleep 1;
			detach _cargo;
			deleteVehicle _chute;
			
			sleep 3;
			deleteVehicle _flare;
			deleteVehicle _smoke;
			PVDZ_veh_Save = [_cargo,"position",true];
			//systemChat "Object saved";
			if (isServer) then {
				PVDZ_veh_Save call server_updateObject;
			} else {
				publicVariableServer "PVDZ_veh_Save";
			};
		};
	};

	//taken from BTC_logistic
	BTC_getHeight = {
		private ["_height","_chopper","_cargo","_cargo_position","_cargo_position_asl","_objects"];
		_chopper = _this select 0;
		_cargo = _this select 1;
		
		_cargo_position = getpos(_cargo);
		_cargo_position_asl = getposASL(_cargo);
		//diag_log format ["DEBUG BTC LIFT: Get Cargo Pos: %1", _cargo_position];
		//diag_log format ["DEBUG BTC LIFT: Get Cargo Pos ASL: %1", _cargo_position_asl];
		_height = 0;

		//diag_log ("DEBUG BTC LIFT: Getting Objects");
		_objects = lineIntersectsWith [_cargo_position_asl, [(_cargo_position_asl select 0), (_cargo_position_asl select 1), -2000], _chopper, _cargo, true];
		//diag_log format ["DEBUG BTC LIFT: Objects: %1", _objects];
		if ((count _objects) > 0) then {
			//diag_log ("DEBUG BTC LIFT: Object count check true");
			_height = _cargo distance (_objects select 0);
		} else {
			//diag_log ("DEBUG BTC LIFT: Object count check false");
			_height = _cargo_position select 2;
		};
		//diag_log format ["DEBUG BTC LIFT: Pre _height: %1", _height];
		_height
	};
	
	LOG_READY = true;
};