#include "script_component.hpp"

if (isServer) then {
    GVAR(saveLoadout) = getMissionConfigValue [QGVAR(savePlayerLoadout), false] in [true, 1];
    GVAR(savePosition) = getMissionConfigValue [QGVAR(savePlayerPosition), false] in [true, 1];
    GVAR(persist) = !is3DENPreview && getMissionConfigValue [QGVAR(serverRestart), false] in [true, 1];

    GVAR(currentState) = [] call CBA_fnc_createNamespace;
    GVAR(persistence) = [] call CBA_fnc_createNamespace;
    GVAR(runCount) = 0;

    if (!GVAR(saveLoadout) && !GVAR(savePosition) && !GVAR(persist)) exitWith {};

    GVAR(saveKey) = format ["efn_save_%1.%2", missionName, worldName];

    addMissionEventHandler ["PlayerDisconnected", {
        params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
        diag_log text format ["Player Disconnected %1", str _this];

        if (_owner == 2 && GVAR(persist)) then {
            [] call FUNC(forceSave);
        };
    }];

    addMissionEventHandler ["HandleDisconnect", {
        params ["_unit", "_id", "_uid", "_name"];
        diag_log text format ["Handle Disconnect %1", str _this];
        private _unitState = [_unit] call FUNC(buildUnitState);
        GVAR(currentState) setVariable [_uid, _unitState];

        // We don't want the unit to live on as AI
        false
    }];
    [{CBA_missionTime > 0}, {
        if (GVAR(persist)) then {
            private _hash = profileNamespace getVariable [GVAR(saveKey), [] call CBA_fnc_hashCreate];
            [_hash] call FUNC(loadState);
        };
    }] call CBA_fnc_waitUntilAndExecute;
};

if !(hasInterface) exitWith {};

[player, "killed", {
    player setVariable [QGVAR(loadout), player call FUNC(getSanitizedUnitLoadout), 2];
}] call CBA_fnc_addBISEventHandler;

[player, "respawn", {
    player setVariable [QGVAR(loadout), nil, 2];
}] call CBA_fnc_addBISEventHandler;

["loadout", {
    params ["", "_newLoadout"];
    player setVariable [QGVAR(facewear), _newLoadout select 7, 2];
}] call CBA_fnc_addPlayerEventHandler;

nil