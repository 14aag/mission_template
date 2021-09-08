#include "script_component.hpp"
params ["_unit", "_undercover", "_entireGroup", "_spottingSides"];

private _group = group _unit;
private _newSide = if (_undercover) then { civilian } else { _group getVariable [QGVAR(originalSide), sideUnknown]};
private _currentSide = side _group;

if (_currentSide == _newSide) exitWith { false };

if (_entireGroup || {count units _group == 1}) then {
    [_group, _newSide] call zen_common_fnc_changeGroupSide;
} else {
    [_unit] joinSilent createGroup [_newSide, true];
};

private _newGroup = group _unit;
_newGroup setVariable ["leader_name", _group getVariable "leader_name", true];

if (_undercover) then {
    _newGroup setVariable [QGVAR(spottingSides), _spottingSides, true];
    _newGroup setVariable [QGVAR(isUndercover), _undercover, true];
    _newGroup setVariable [QGVAR(originalSide), _currentSide, true];
};

[QGVAR(setUndercover), [_newGroup, _undercover], _newGroup] call CBA_fnc_targetEvent;

true
