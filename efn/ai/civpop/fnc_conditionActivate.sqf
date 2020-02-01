#include "script_component.hpp"
params ["_logic"];
private _lastCheck = _logic getVariable [QGVAR(lastActivationCheck), -1];

private _ret = false;
if (CBA_missionTime >= (_lastCheck + 0.5)) then {
    private _activationDistance = _logic getVariable [QGVAR(activation), 0];
    _ret = [_logic, _activationDistance] call FUNC(findPlayer);
    _logic setVariable [QGVAR(lastActivationCheck), CBA_missionTime];
};

_ret