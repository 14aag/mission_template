#include "script_component.hpp"

params ["_unit", "_isLeader"];

if (_isLeader && isNil QGVAR(actionId)) then {
    private _condition = QUOTE(vehicle player == player && {isNull GVAR(tent)});
    GVAR(actionId) = _unit addAction ["Place respawn", FUNC(placeTent), nil, 0, false, true, "", _condition];
};

if (!_isLeader && !(isNil QGVAR(actionId))) then {
    _unit removeAction GVAR(actionId);
    GVAR(actionId) = nil;
};

nil
