#include "script_component.hpp"
params ["_vehicle", "_supply"];

[_vehicle] call FUNC(initSupplyVehicle);

if (isServer) then {
    _vehicle setVariable ["ace_rearm_magazineSupply", _supply, true];
    [_vehicle, true, [0,1,1], 0, true] call ace_dragging_fnc_setCarryable;
};
