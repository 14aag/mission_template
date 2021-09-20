#include "script_component.hpp"

if !(GVAR(persist)) exitWith {};

{
    private _uid = getPlayerUID _x;
    private _unitState = [_x] call FUNC(buildUnitState);

    GVAR(currentState) set [_uid, _unitState];
} forEach allPlayers;

GVAR(currentState) set ["containers", call FUNC(buildContainersState)];
GVAR(currentState) set ["vehicles", call FUNC(buildVehiclesState)];
GVAR(currentState) set ["runCount", GVAR(runCount)];
[] call FUNC(save);
