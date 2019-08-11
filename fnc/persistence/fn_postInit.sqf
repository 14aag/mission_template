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
        private _loadout = if (efn_saveLoadout) then {[_unit] call efn_persistence_fnc_getSanitizedUnitLoadout} else {objNull};
        private _pos = if (efn_savePosition) then {[getDir _unit, getPosASL _unit]} else {objNull};

        efn_persistence setVariable [_uid, [_loadout, _pos]];

        // We don't want the unit to live on as AI
        false
    }];

    addMissionEventHandler ["PlayerDisconnected", {
        params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
        if ("__SERVER__" isEqualTo _name && efn_persist) then {
            [] call efn_persistence_fnc_save;
        };

        nil
    }];

    addMissionEventHandler ["PlayerConnected", {
        params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
        private _data = efn_persistence getVariable [_uid, []];
        if !(_data isEqualTo []) then {
            ["efn_player_state", _data, _owner] call CBA_fnc_ownerEvent;
        };

        nil
    }];
};

nil