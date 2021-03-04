#include "script_component.hpp"
params ["_hash"];

GVAR(persistence) call CBA_fnc_deleteNamespace;
GVAR(persistence) = [_hash] call CBA_fnc_deserializeNamespace;
GVAR(runCount) = (GVAR(persistence) getVariable ["runCount", 0]) + 1;

private _containers = GVAR(persistence) getVariable ["containers", []];
[_containers] call FUNC(restoreContainersState);
private _vehicles = GVAR(persistence) getVariable ["vehicles", []];
[_vehicles] call FUNC(restoreVehiclesState);

{
	GVAR(persistence) getVariable [getPlayerUID _x, []] params [["_data", [], [[]]], ["_lastRun", 0, [0]]];
	if !(_data isEqualTo []) then {
		[QGVAR(player_state), _data, _x] call CBA_fnc_targetEvent;
	};
} forEach call CBA_fnc_players;

GVAR(currentState) call CBA_fnc_deleteNamespace;
GVAR(currentState) = [_hash] call CBA_fnc_deserializeNamespace;
