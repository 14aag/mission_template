#include "script_component.hpp"

if !(GVAR(persist)) exitWith {};

{
    private _uid = getPlayerUID _x;
    private _unitState = [_x] call FUNC(buildUnitState);

    GVAR(currentState) setVariable [_uid, _unitState];
} forEach allPlayers;

GVAR(currentState) setVariable ["containers", call FUNC(buildContainersState)];
GVAR(currentState) setVariable ["vehicles", call FUNC(buildVehiclesState)];
GVAR(currentState) setVariable ["runCount", GVAR(runCount)];
[] call FUNC(save);
