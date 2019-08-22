params ["_unit"];

private _leaderName = (group _unit) getVariable ["leader_name", ""];
private _leader = leader _unit;

if (_leaderName isEqualTo "") exitWith {
    [_unit, false] call efn_respawn_fnc_setAction;
};

[_unit, _leader == _unit] call efn_respawn_fnc_setAction;

nil
