#include "script_component.hpp"

{
    if (_x isKindOf "Land") then {
        _transport = isVehicleCargo _x;
        if !(isNull _transport) then {
            objNull setVehicleCargo _x;
        };
    };
} forEach _this;
