#include "script_component.hpp"

params ["_target"];

GVAR(currentState) getVariable [getPlayerUID _target, []] params [["_data", [], [[]]], ["_lastRun", 0, [0]]];
if !(_data isEqualTo []) then {
    [QGVAR(player_state), _data, _target] call CBA_fnc_targetEvent;
};

nil