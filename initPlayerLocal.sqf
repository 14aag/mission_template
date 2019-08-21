[player, "killed", {
    player setVariable ["saved_loadout", getUnitLoadout player];
}] call CBA_fnc_addBISEventHandler;

[player, "respawn", {
    private _loadout = player getVariable ["saved_loadout", []];
    if !(_loadout isEqualTo []) then {
        player setUnitLoadout _loadout;
    }
}] call CBA_fnc_addBISEventHandler;

["efn_player_ready", [player]] call CBA_fnc_serverEvent;
