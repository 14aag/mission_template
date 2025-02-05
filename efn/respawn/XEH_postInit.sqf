#include "script_component.hpp"

GVAR(tentType) = getMissionConfigValue [QGVAR(tentType), "Misc_Backpackheap"];
if (!(GVAR(tentType) isEqualType "") || {GVAR(tentType) isEqualTo ""}) then {
    GVAR(tentType) = "Misc_Backpackheap";
};

if (isServer) then {
    [QGVAR(handle_player_respawn), FUNC(handlePlayerRespawnEvent)] call CBA_fnc_addEventHandler;
    [QGVAR(place_tent), FUNC(handlePlaceTentEvent)] call CBA_fnc_addEventHandler;

    GVAR(ticketCount) = getMissionConfigValue [QGVAR(ticketCount), 0];
    GVAR(minDistance) = getMissionConfigValue [QGVAR(minDistance), 0];
    GVAR(outOfTicketsRemove) = getMissionConfigValue [QGVAR(outOfTicketsRemove), true] in [true, 1];
    GVAR(tentCooldown) = getMissionConfigValue [QGVAR(tentCooldown), 0];

    call FUNC(airdropStatemachine);

    if (!isNil QGVAR(vehicle) && !isNull GVAR(vehicle) && {GVAR(vehicle) isKindOf "Air"}) then {
        GVAR(vehicles) pushBack GVAR(vehicle);
    };
};
GVAR(mode) = getMissionConfigValue [QGVAR(mode), 1];

if (!hasInterface) exitWith {};

GVAR(minPlayersNear) = getMissionConfigValue [QGVAR(minPlayersNear), 1];
GVAR(maxPlayerDistance) = getMissionConfigValue [QGVAR(maxPlayerDistance), 5];
GVAR(timer) = getMissionConfigValue [QGVAR(timer), 0];
GVAR(showGridOnSpawn) = getMissionConfigValue [QGVAR(showGridOnSpawn), false] in [true, 1];
GVAR(enabled) = GVAR(mode) != RESPAWN_MODE_DISABLED;

[player, "killed", {
    if (GVAR(mode) == RESPAWN_MODE_DROPZONE && {GVAR(dropzones) isNotEqualTo []}) then {
        player setVariable [QGVAR(dropzone), [GVAR(dropzones), getPosASL player] call BIS_fnc_nearestPosition, 2];
    };
    player setVariable [QGVAR(saved_loadout), getUnitLoadout player];
    [player, false] call FUNC(setAction);
}] call CBA_fnc_addBISEventHandler;

[player, "respawn", {
    params ["_unit", "_corpse"];
    [player] call FUNC(updateLeaderName);
    private _loadout = player getVariable [QGVAR(saved_loadout), []];
    if !(_loadout isEqualTo []) then {
        player setUnitLoadout _loadout;
    };

    if (!isNil QGVAR(position) && !isNull GVAR(position)) then {
        player setPosASL getPosASL GVAR(position);
    };

    player setVariable [QGVAR(corpse), _corpse];
    if (GVAR(enabled)) then {
        player setVariable [QGVAR(dead), true, true];
        [true] call FUNC(setSpectator);
        [{
            if (player getVariable [QGVAR(dead), false]) then {
                [QGVAR(handle_player_respawn), [player]] call CBA_fnc_serverEvent;
            };
        }, [], GVAR(timer)] call CBA_fnc_waitAndExecute;
    } else {
        [QGVAR(respawn), []] call CBA_fnc_localEvent;
    };

    nil
}] call CBA_fnc_addBISEventHandler;

["ace_interactMenuOpened", {
    call FUNC(endTentPlacementMode);
}] call CBA_fnc_addEventHandler;

["leader", {
    [player] call FUNC(updateLeaderName);
}, true] call CBA_fnc_addPlayerEventHandler;

[QGVAR(respawn), {
    private _corpse = player getVariable [QGVAR(corpse), objNull];
    if (!isNull _corpse) then {
        hideBody _corpse;
    };
    player setVariable [QGVAR(corpse), nil];
    player setVariable [QGVAR(dead), false, true];

    if (GVAR(mode) == RESPAWN_MODE_DROPZONE || GVAR(mode) == RESPAWN_MODE_VEHICLE) then {
        if (!isNil QGVAR(vehicle) && !isNull GVAR(vehicle) && alive GVAR(vehicle)) then {
            if (GVAR(mode) == RESPAWN_MODE_DROPZONE && {GVAR(vehicle) isKindOf "Air"}) then {
                [player] call bocr_main_fnc_actionOnChest;
                player addBackpack "B_Parachute";
            };

            player moveInCargo GVAR(vehicle);
        };
    };

    [false] call FUNC(setSpectator);
    if (GVAR(showGridOnSpawn)) then {
        private _grid = [getPos player] call ace_common_fnc_getMapGridFromPos;
        systemChat format ["Spawned at %1 %2", (_grid select 0) select [0, 3], (_grid select 1) select [0, 3]];
    };
}] call CBA_fnc_addEventHandler;
[QGVAR(force_leader_name_update), { [player] call FUNC(updateLeaderName); }] call CBA_fnc_addEventHandler;
[QGVAR(notify), FUNC(notify)] call CBA_fnc_addEventHandler;
[QGVAR(tent_placed), { player playActionNow "PutDown"; }] call CBA_fnc_addEventHandler;
[QGVAR(set_mode), {
    GVAR(mode) = _this;
    GVAR(enabled) = _this != RESPAWN_MODE_DISABLED;
    [player] call FUNC(updateLeaderName);
}] call CBA_fnc_addEventHandler;

[missionNamespace, "OnGameInterrupt", {
    params ["_display"];
    if (ace_spectator_isSet) then {
        (_display displayCtrl 1010) ctrlEnable false;
    };
}] call BIS_fnc_addScriptedEventHandler;

nil
