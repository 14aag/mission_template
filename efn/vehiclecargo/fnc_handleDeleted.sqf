#include "script_component.hpp"
params ["_object"];

{
	detach _x;
	deleteVehicle _x;
} forEach (_object getVariable [QGVAR(loaded), []]);

private _storage = _object getVariable [QGVAR(storage), objNull];
if !(isNull _storage) then {
	private _cargo = _storage getVariable [QGVAR(assignedCargo), []];
	private _index = _cargo find _object;
	_cargo deleteAt _index;
	_storage setVariable [QGVAR(assignedCargo), _cargo, true];

	private _loaded = _storage getVariable [QGVAR(loaded), []];
	_loaded deleteAt _index;
	_storage setVariable [QGVAR(loaded), _loaded, true];
};
