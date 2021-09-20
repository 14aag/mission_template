#include "script_component.hpp"
params ["_hash"];

GVAR(persistence) = _hash;
GVAR(runCount) = (GVAR(persistence) getOrDefault ["runCount", 0]) + 1;

private _containers = GVAR(persistence) getOrDefault ["containers", []];
[_containers] call FUNC(restoreContainersState);
private _vehicles = GVAR(persistence) getOrDefault ["vehicles", []];
[_vehicles] call FUNC(restoreVehiclesState);

{
	GVAR(persistence) getOrDefault [getPlayerUID _x, []] params [["_data", [], [[]]], ["_lastRun", 0, [0]]];
	if !(_data isEqualTo []) then {
		[QGVAR(player_state), _data, _x] call CBA_fnc_targetEvent;
	};
} forEach call CBA_fnc_players;

GVAR(currentState) = +_hash;
