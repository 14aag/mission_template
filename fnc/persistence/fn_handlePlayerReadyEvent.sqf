#include "script_component.hpp"

params ["_target"];

private _data = GVAR(persistence) getVariable [getPlayerUID _target, []];
if !(_data isEqualTo []) then {
    [QGVAR(player_state), _data, _target] call CBA_fnc_targetEvent;
};

nil