#include "script_component.hpp"
params ["_logic"];

private _units = _logic getVariable [QGVAR(units), []];
private _vehicles = _logic getVariable [QGVAR(vehicles), []];

{
	deleteVehicle _x;
} forEach (_units + _vehicles);

_logic setVariable [QGVAR(units), []];
_logic setVariable [QGVAR(vehicles), []];
