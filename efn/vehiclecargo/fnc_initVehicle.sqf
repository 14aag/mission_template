#include "script_component.hpp"
params ["_vehicle", ["_initialCargo", [], [[]]]];

if (isServer) then {
    _vehicle setVariable [QGVAR(hasCargo), true, true];
    [_vehicle, _initialCargo] call FUNC(addCargo);
    [QGVAR(initVehicleActions), [_vehicle]] call CBA_fnc_globalEventJIP;
};
