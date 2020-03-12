#include "script_component.hpp"
params ["_agent"];

private _firedTime = _agent getVariable [QGVAR(firedTime), -1];

(CBA_missionTime - _firedTime) > 300