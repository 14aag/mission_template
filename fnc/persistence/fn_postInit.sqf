if (isServer) then {
    efn_saveLoadout = getMissionConfigValue ["efn_persistence_savePlayerLoadout", false] in [true, 1];
    efn_savePosition = getMissionConfigValue ["efn_persistence_savePlayerPosition", false] in [true, 1];

    if (!efn_saveLoadout && !efn_savePosition) exitWith {};
    efn_persist = getMissionConfigValue ["efn_persistence_serverRestart", false] in [true, 1];

    efn_save_key = format ["efn_save_%1.%2", missionName, worldName];
    private _hash = if (efn_persist) then {profileNamespace getVariable [efn_save_key, [] call CBA_fnc_hashCreate]} else {[] call CBA_fnc_hashCreate};
    efn_persistence = [_hash] call CBA_fnc_deserializeNamespace;

    addMissionEventHandler ["HandleDisconnect", {
        params ["_unit", "_id", "_uid", "_name"];
        private _unitState = [_unit] call efn_persistence_fnc_buildUnitState;
        efn_persistence setVariable [_uid, _unitState];

        private _playerCount = count allPlayers;
        if (_playerCount == 0 && efn_persist) then {
            [] call efn_persistence_fnc_save;
        };

        // We don't want the unit to live on as AI
        false
    }];
};

if !(hasInterface) exitWith {};

[player, "killed", {
    player setVariable ["efn_persistence_loadout", player call efn_persistence_fnc_getSanitizedUnitLoadout, true];
}] call CBA_fnc_addBISEventHandler;

[player, "respawn", {
    player setVariable ["efn_persistence_loadout", nil, true];
}] call CBA_fnc_addBISEventHandler;

["efn_persistence_player_ready", [player]] call CBA_fnc_serverEvent;

nil