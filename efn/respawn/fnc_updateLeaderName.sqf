#include "script_component.hpp"

params ["_unit"];

private _leaderName = (group _unit) getVariable ["leader_name", ""];
private _leader = leader _unit;

if (_leaderName isEqualTo "") exitWith {
    [_unit, false] call FUNC(setAction);
};

[_unit, GVAR(enabled) && _leader == _unit] call FUNC(setAction);

nil
