#include "script_component.hpp"
params [["_endMission", false, [true]]];

GVAR(currentState) = createHashMap;
[] call FUNC(save);
GVAR(persist) = false;

if (_endMission) then {
    "ResetMission" call BIS_fnc_endMissionServer;
};
