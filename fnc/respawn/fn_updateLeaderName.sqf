params ["_unit"];

private _leaderName = (group _unit) getVariable ["leader_name", ""];
private _leader = leader _unit;
if !(_leaderName isEqualTo "") then {
    if !(isNil _leaderName) then {
        _obj = missionNamespace getVariable [_leaderName, _obj];
        _obj setVehicleVarName "";
    };
};

[_unit, _leader == _unit] call efn_respawn_fnc_setAction;

_leader setVehicleVarName _leaderName;
if !(_leaderName isEqualTo "") then {
    missionNamespace setVariable [_leaderName, _leader];
};

nil
