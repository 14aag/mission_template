#include "script_component.hpp"

params ["_unit"];

[_unit] call FUNC(movePlayerToSpawn);
[QGVAR(respawn), [], _unit] call CBA_fnc_targetEvent;
