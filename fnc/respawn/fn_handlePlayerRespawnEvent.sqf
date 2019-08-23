#include "script_component.hpp"

params ["_unit"];

[_unit] call FUNC(movePlayerToSpawn);
[QGVAR(set_spectator), [false], _unit] call CBA_fnc_targetEvent;

