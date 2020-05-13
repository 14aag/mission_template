#include "script_component.hpp"

if !(GVAR(persist)) exitWith {};

{
    private _uid = getPlayerUID _x;
    private _unitState = [_x] call FUNC(buildUnitState);

    GVAR(persistence) setVariable [_uid, _unitState];
} forEach allPlayers;

GVAR(persistence) setVariable ["containers", call FUNC(buildContainersState)];
GVAR(persistence) setVariable ["vehicles", call FUNC(buildVehiclesState)];
GVAR(persistence) setVariable ["runCount", GVAR(runCount)];
[] call FUNC(save);
