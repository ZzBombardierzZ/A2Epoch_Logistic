sleep 0.1;
private ["_transportable","_allCanLift","_allCanTow","_known","_list","_count","_i","_object"];
_transportable = LOG_CFG_ISTOWABLE_TINY + LOG_CFG_ISTOWABLE_SMALL + LOG_CFG_ISTOWABLE_MEDIUM + LOG_CFG_ISTOWABLE_LARGE + LOG_CFG_ISTOWABLE_AIRTUG + LOG_CFG_ISLIFTABLE_TINY + LOG_CFG_ISLIFTABLE_SMALL + LOG_CFG_ISLIFTABLE_MEDIUM + LOG_CFG_ISLIFTABLE_LARGE;
_allCanLift = LOG_CFG_CANLIFT_TINY + LOG_CFG_CANLIFT_SMALL + LOG_CFG_CANLIFT_MEDIUM + LOG_CFG_CANLIFT_LARGE;
_allCanTow  = LOG_CFG_CANTOW_TINY + LOG_CFG_CANTOW_SMALL + LOG_CFG_CANTOW_MEDIUM + LOG_CFG_CANTOW_LARGE + LOG_CFG_CANTOW_AIRTUG;
_known = [];
while {true} do{
	if !(isNull player) then{
		_list = (vehicles + nearestObjects [player, ["Static"], 80]) - _known;
		_count = count _list;
		if (_count > 0) then{
			for [{_i = 0}, {_i < _count}, {_i = _i + 1}] do{
				_object = _list select _i;
				if ({_object isKindOf _x} count _transportable > 0) then{[_object] spawn LOG_OBJ_INIT;};	//can be towed/lifted -> add tow/untow actions
				if ({_object isKindOf _x} count _allCanLift > 0) then{[_object] spawn LOG_LIFT_INIT;};		//can lift -> add lift/drop actions
				if ({_object isKindOf _x} count _allCanTow > 0) then{[_object] spawn LOG_TOW_INIT;};			//can tow -> add tug actions
				sleep (18/_count);
			};
			_known = _known + _list;
		}else{sleep 18;};
	}else{sleep 2;};
};
