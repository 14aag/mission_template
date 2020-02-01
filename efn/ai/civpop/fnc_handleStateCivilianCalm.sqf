#include "script_component.hpp"
params ["_agent"];

private _nextMove = _agent getVariable [QGVAR(nextMove), CBA_missionTime];
if (CBA_missionTime >= _nextMove) then {
    _agent call FUNC(move);
    _agent setVariable [QGVAR(nextMove), CBA_missionTime + random [60, 90, 150]];
};

nil