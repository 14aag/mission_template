#include "script_component.hpp"
params ["_logic", "_radius", "_heightVar"];

if !(isServer) exitWith {};

["zen_common_setName", [_logic, "Flak"]] call CBA_fnc_globalEventJIP;
[_logic, QFUNC(flakEffect_run), [_radius, _heightVar]] call FUNC(initEffect);
