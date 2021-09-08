#include "script_component.hpp"
params ["_unit", "_distance"];

private _group = group _unit;
private _side = _group getVariable QGVAR(originalSide);
private _spottingSides = _group getVariable [QGVAR(spottingSides), []];
if (_spottingSides isEqualTo []) then {
	_spottingSides = [_side] call FUNC(getEnemySides);
};

private _objects = nearestObjects [_unit, ["CAManBase"], _distance, false];
private _spotters = [];

{
	if (alive _x && {!(_x getVariable ["ace_isUnconscious", false])} && {side _x in _spottingSides}) then {
		_spotters pushBack _x;
	};
} forEach _objects;

_spotters
