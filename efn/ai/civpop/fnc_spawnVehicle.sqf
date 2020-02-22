#include "script_component.hpp"
params ["_spot", "_vehicleType"];
_spot params ["_position", "_direction"];

private _vehicle = createVehicle [_vehicleType, _position, [], 0, "NONE"];
_vehicle setDir _direction;

_vehicle
