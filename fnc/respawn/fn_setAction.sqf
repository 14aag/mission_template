#include "script_component.hpp"

params ["_unit", "_isLeader"];

if (_isLeader && isNil QGVAR(actionId)) then {
    GVAR(actionId) = _unit addAction ["Place respawn", FUNC(placeTent), nil, 0, false];
};

if (!_isLeader && !(isNil QGVAR(actionId))) then {
    _unit removeAction GVAR(actionId);
    GVAR(actionId) = nil;
};

nil
