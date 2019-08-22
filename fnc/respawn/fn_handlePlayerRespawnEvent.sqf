params ["_unit"];

[_unit] call efn_respawn_fnc_movePlayerToSpawn;
["efn_respawn_set_spectator", [false], _unit] call CBA_fnc_targetEvent;

