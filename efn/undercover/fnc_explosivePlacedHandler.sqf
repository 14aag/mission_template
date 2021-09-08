#include "script_component.hpp"
params ["_explosive", "", "", "_unit"];

if (local _unit && {_unit getVariable [QGVAR(monitorActive), false]}) then {
    private _spotters = [_unit, 500] call FUNC(findPotentialSpotters);
    private _spotted = [_unit, _spotters] call FUNC(findVisibleSpotter);

    if (_spotted >= 0) then {
        [_unit, _spotters select _spotted] call FUNC(spotted);
    };
};
