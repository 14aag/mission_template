#include "script_component.hpp"
params ["_pos", "_range"];
if !(isServer) exitWith {};

if (isNil QGVAR(logicGroup) || {isNull GVAR(logicGroup)}) then {
    GVAR(logicGroup) = createGroup sideLogic;
    GVAR(logicGroup) setGroupIdGlobal ["Ambient Effects"];
};

private _logic = GVAR(logicGroup) createUnit ["Logic", _pos, [], 0, "CAN_COLLIDE"];
_logic setPosASL _pos;
[_logic, _range] call FUNC(initArtillery);
