#include "script_component.hpp"
params ["_logic", "_range"];

if !(isServer) exitWith {};

["zen_common_setName", [_logic, "Artillery"]] call CBA_fnc_globalEventJIP;
[_logic, QFUNC(artilleryEffect_run), [_range]] call FUNC(initEffect);
