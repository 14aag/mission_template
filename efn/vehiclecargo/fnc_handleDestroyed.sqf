#include "script_component.hpp"
params ["_object"];

private _loaded = _object getVariable [QGVAR(loaded), []];
if (_loaded isEqualTo []) then {
    private _storage = _object getVariable [QGVAR(storage), objNull];
    if !(isNull _storage) then {
        _loaded = _storage getVariable [QGVAR(loaded), []];
        _storage setVariable [QGVAR(loaded), [], true];
        _storage setVariable [QGVAR(assignedCargo), [], true];
    };
};

{
    detach _x;
    deleteVehicle _x;
} forEach _loaded;
