#include "script_component.hpp"
params ["_unit"];

if (!(_unit getVariable [QGVAR(hasContainer), true])) exitWith {};
private _type = _unit getVariable [QGVAR(containerType), ""];
if (_type isEqualTo "") exitWith {};

private _supply = _unit getVariable [QGVAR(containerSupply), []];
private _vehicle = createVehicle [_type, [0,0,0], [], 0, "CAN_COLLIDE"];
_vehicle setPos (_unit getPos [0.2, getDir _unit]);
_vehicle setVariable ["ace_rearm_magazineSupply", _supply, true];
[_vehicle, true, [0,1,1], 0, true] call ace_dragging_fnc_setCarryable;
[QGVAR(initSupplyVehicle), _vehicle] call CBA_fnc_globalEvent;
[player, _vehicle] call ace_dragging_fnc_startCarry;

_unit setVariable [QGVAR(hasContainer), false];
_unit setVariable [QGVAR(containerSupply), nil];
_unit setVariable [QGVAR(containerType), nil];
