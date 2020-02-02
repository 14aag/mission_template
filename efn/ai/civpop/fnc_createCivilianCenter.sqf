#include "script_component.hpp"
params ["_pos", "_size", "_amount", "_preset"];

if (isNil QGVAR(logicGroup) || {isNull GVAR(logicgroup)}) then {
    GVAR(logicGroup) = createGroup sideLogic;
};
private _logic = GVAR(logicGroup) createUnit ["Logic", _pos, [], 0, "CAN_COLLIDE"];
[_logic, _size, _size, _preset, _amount] call FUNC(init);
