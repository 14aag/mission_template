#include "script_component.hpp"
params ["_vehicle"];

private _loaded = _vehicle getVariable [QGVAR(loaded), []];
private _assigned = _vehicle getVariable [QGVAR(assignedCargo), []];

_loaded isEqualTo _assigned;
