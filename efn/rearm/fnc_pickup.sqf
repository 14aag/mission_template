#include "script_component.hpp"
params ["_vehicle", "_unit"];

if (_unit getVariable [QGVAR(hasContainer), false]) exitWith {};

private _supply = _vehicle getVariable ["ace_rearm_magazineSupply", []];
private _type = typeOf _vehicle;

deleteVehicle _vehicle;
_unit setVariable [QGVAR(containerSupply), _supply];
_unit setVariable [QGVAR(containerType), _type];
_unit setVariable [QGVAR(hasContainer), true];

