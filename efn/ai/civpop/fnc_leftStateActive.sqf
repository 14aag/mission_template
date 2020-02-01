#include "script_component.hpp"
params ["_logic"];

private _units = _logic getVariable [QGVAR(units), []];

{
	deleteVehicle _x;
} forEach _units;

_logic setVariable [QGVAR(units), []];