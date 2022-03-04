#include "script_component.hpp"
params ["_pos", "_color", ["_direction", [180, 180], [[]], 2], ["_angle", [60, 30], [[]], 2], ["_velocityRange", [500, 50], [[]], 2], ["_size", 50, [0]]];
if !(isServer) exitWith {};

if (isNil QGVAR(logicGroup) || {isNull GVAR(logicGroup)}) then {
    GVAR(logicGroup) = createGroup sideLogic;
    GVAR(logicGroup) setGroupIdGlobal ["Ambient Effects"];
};

private _logic = GVAR(logicGroup) createUnit ["Logic", _pos, [], 0, "CAN_COLLIDE"];
_logic setPosASL _pos;
[_logic, _color, _direction, _angle, _velocityRange, _size] call FUNC(initTracers);
