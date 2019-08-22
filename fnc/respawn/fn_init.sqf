if (isServer) then {
    ["efn_respawn_handle_player_respawn", efn_respawn_fnc_handlePlayerRespawnEvent] call CBA_fnc_addEventHandler;
    ["efn_respawn_place_tent", efn_respawn_fnc_handlePlaceTentEvent] call CBA_fnc_addEventHandler;

    efn_respawn_ticketCount = getMissionConfigValue ["efn_respawn_ticketCount", 0];
};

if (!hasInterface) exitWith {};

efn_respawn_timer = getMissionConfigValue ["efn_respawn_timer", 0];
[player, "killed", {
    player setVariable ["saved_loadout", getUnitLoadout player];
    [player, false] call efn_respawn_fnc_setAction;
}] call CBA_fnc_addBISEventHandler;

[player, "respawn", {
    params ["_unit", "_corpse"];
    [player] call efn_respawn_fnc_updateLeaderName;
    private _loadout = player getVariable ["saved_loadout", []];
    if !(_loadout isEqualTo []) then {
        player setUnitLoadout _loadout;
    };

    [true] call ace_spectator_fnc_setSpectator;
    [{
        ["efn_respawn_handle_player_respawn", [player]] call CBA_fnc_serverEvent;
        hideBody (_this select 0);
    }, [_corpse], efn_respawn_timer] call CBA_fnc_waitAndExecute;

    nil
}] call CBA_fnc_addBISEventHandler;

["leader", {
    [player] call efn_respawn_fnc_updateLeaderName;
}, true] call CBA_fnc_addPlayerEventHandler;

["efn_respawn_set_spectator", ace_spectator_fnc_setSpectator] call CBA_fnc_addEventHandler;
["efn_force_leader_name_update", { [player] call efn_respawn_fnc_updateLeaderName; }] call CBA_fnc_addEventHandler;

nil
