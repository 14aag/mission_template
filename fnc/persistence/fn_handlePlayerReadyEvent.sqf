params ["_target"];

private _data = efn_persistence getVariable [getPlayerUID _target, []];
if !(_data isEqualTo []) then {
    ["efn_persistence_player_state", _data, _target] call CBA_fnc_targetEvent;
};

nil