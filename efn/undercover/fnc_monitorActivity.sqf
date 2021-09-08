#include "script_component.hpp"
params ["_unit", "_enable"];

if (_enable) then {
    _unit setVariable [QGVAR(firedEHID), [_unit, "FiredMan", FUNC(firedHandler)] call CBA_fnc_addBISEventHandler];
} else {
    private _id = _unit getVariable [QGVAR(firedEHID), -1];
    if (_id != -1) then {
        _unit removeEventHandler ["FiredMan", _id];
    };
};

_unit setVariable [QGVAR(monitorActive), _enable];
