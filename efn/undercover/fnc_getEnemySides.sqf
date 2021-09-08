#include "script_component.hpp"
params ["_side"];

private _enemies = [];
{
	if ([_side, _x] call BIS_fnc_sideIsEnemy) then {
		_enemies pushBack _x;
	};
} forEach [blufor, opfor, resistance, civilian];

_enemies
