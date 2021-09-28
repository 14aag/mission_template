#include "script_component.hpp"
params ["_cargo", "_storage"];

private _assigned = _storage getVariable [QGVAR(assignedCargo), []];
private _loaded = _storage getVariable [QGVAR(loaded), []];

private _index = _assigned find _cargo;
_index >= 0 && !(_cargo in _loaded)
