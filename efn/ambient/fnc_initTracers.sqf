#include "script_component.hpp"
params ["_logic", "_color", ["_direction", [180, 180], [[]], 2], ["_angle", [60, 30], [[]], 2], ["_velocityRange", [500, 50], [[]], 2], ["_size", 50, [0]]];

if !(isServer) exitWith {};

["zen_common_setName", [_logic, "Tracers"]] call CBA_fnc_globalEventJIP;

[_logic, QFUNC(tracerEffect_run), [_color, _direction, _angle, _velocityRange, _size]] call FUNC(initEffect);
