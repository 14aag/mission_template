#include "script_component.hpp"

if (isServer) then {
    [QGVAR(handle_player_respawn), FUNC(handlePlayerRespawnEvent)] call CBA_fnc_addEventHandler;
    [QGVAR(place_tent), FUNC(handlePlaceTentEvent)] call CBA_fnc_addEventHandler;

    GVAR(ticketCount) = getMissionConfigValue [QGVAR(ticketCount), 0];
};

if (!hasInterface) exitWith {};

GVAR(timer) = getMissionConfigValue [QGVAR(timer), 0];
GVAR(spectatorDelay) = 0.1;
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

    [{
        [true] call FUNC(setSpectator);
    }, [], GVAR(spectatorDelay)] call CBA_fnc_waitAndExecute;
    [{
        [QGVAR(handle_player_respawn), [player]] call CBA_fnc_serverEvent;
        hideBody (_this select 0);
    }, [_corpse], GVAR(timer)] call CBA_fnc_waitAndExecute;

    nil
}] call CBA_fnc_addBISEventHandler;

["leader", {
    [player] call FUNC(updateLeaderName);
}, true] call CBA_fnc_addPlayerEventHandler;

[QGVAR(set_spectator), FUNC(setSpectator)] call CBA_fnc_addEventHandler;
[QGVARMAIN(force_leader_name_update), { [player] call FUNC(updateLeaderName); }] call CBA_fnc_addEventHandler;

nil
