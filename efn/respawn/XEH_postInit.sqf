#include "script_component.hpp"

if (isServer) then {
    [QGVAR(handle_player_respawn), FUNC(handlePlayerRespawnEvent)] call CBA_fnc_addEventHandler;
    [QGVAR(place_tent), FUNC(handlePlaceTentEvent)] call CBA_fnc_addEventHandler;

    GVAR(ticketCount) = getMissionConfigValue [QGVAR(ticketCount), 0];
    GVAR(minDistance) = getMissionConfigValue [QGVAR(minDistance), 0];
    GVAR(outOfTicketsRemove) = getMissionConfigValue [QGVAR(outOfTicketsRemove), true] in [true, 1];
    GVAR(tentCooldown) = getMissionConfigValue [QGVAR(tentCooldown), 0];
};

if (!hasInterface) exitWith {};

GVAR(mode) = getMissionConfigValue [QGVAR(mode), 1];
GVAR(timer) = getMissionConfigValue [QGVAR(timer), 0];
GVAR(enabled) = GVAR(mode) != RESPAWN_MODE_DISABLED;

[player, "killed", {
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

    if (GVAR(enabled)) then {
        player setVariable [QGVAR(dead), true, true];
        [true] call FUNC(setSpectator);
        player setVariable [QGVAR(corpse), _corpse];
        if (GVAR(mode) == RESPAWN_MODE_TENT) then {
            [{
                if (player getVariable [QGVAR(dead), false]) then {
                    [QGVAR(handle_player_respawn), [player]] call CBA_fnc_serverEvent;
                };
            }, [], GVAR(timer)] call CBA_fnc_waitAndExecute;
        };
    };

    nil
}] call CBA_fnc_addBISEventHandler;

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

    [false] call FUNC(setSpectator);
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
