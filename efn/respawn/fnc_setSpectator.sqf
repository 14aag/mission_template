#include "script_component.hpp"
#define MAIN_DISPLAY ([] call BIS_fnc_displayMission)
/*
 * Author: SilentSpike
 * Enter/exit spectator mode for the local player
 * Copied from ACE for now to not remove the player from the group when in spectator
 *
 * Client will be able to communicate in ACRE/TFAR as appropriate
 * If "hide player" is true player will be hidden from group, invisible and invulnerable, but unmoved
 *
 * Arguments:
 * 0: Spectator state of local client <BOOL> (default: true)
 * 1: Force interface <BOOL> (default: true)
 * 2: Hide player (if alive) <BOOL> (default: true)
 *
 * Return Value:
 * None
 *
 * Example:
 * [true] call efn_respawn_fnc_setSpectator
 *
 * Public: Yes
 */

params [["_set",true,[true]], ["_force",true,[true]], ["_hide",true,[true]]];
TRACE_3("Params",_set,_force,_hide);

// Only clients can be spectators
if !(hasInterface) exitWith {};

// Let the display know if it is or isn't forced
// Could be switched after spectator has already started
ace_spectator_uiForced = _force;

// Exit if no change (everything above this may need to be ran again)
if (_set isEqualTo ace_spectator_isSet) exitWith {};

// Delay if local player (must not be ACE_Player) does not exist
if (isNull player) exitWith {
    [
        { !isNull player },
        FUNC(setSpectator),
        _this
    ] call CBA_fnc_waitUntilAndExecute;
};

// Remove any current deafness and disable volume updates while spectating
if (["ace_hearing"] call ace_common_fnc_isModLoaded) then {
    ace_hearing_disableVolumeUpdate = _set;
    ace_hearing_deafnessDV = 0;
};

// Toggle spectator mode in 3rd party radio addons
if (["acre_sys_radio"] call ace_common_fnc_isModLoaded) then {[_set] call acre_api_fnc_setSpectator};
if (["task_force_radio"] call ace_common_fnc_isModLoaded) then {
    [player, _set] call TFAR_fnc_forceSpectator;
    if (_set) then {
        [{
            if (ace_spectator_isSet && !(player getVariable ["TFAR_forceSpectator", false])) then {
                [player, true] call TFAR_fnc_forceSpectator;
            };
            !ace_spectator_isSet
        }, {}] call CBA_fnc_waitUntilAndExecute;
    };
    if (!_set && TFAR_ShowVolumeHUD) then {
        ("tfar_core_HUDVolumeIndicatorRsc" call BIS_fnc_rscLayer) cutRsc ["tfar_core_HUDVolumeIndicatorRsc", "PLAIN", 0, true];
    };
};

if (_set) then {
    // Initalize the camera
    [true] call ace_spectator_fnc_cam;

    // Create the display when main display is ready
    [{ !isNull MAIN_DISPLAY },{ [true] call ace_spectator_fnc_ui }] call CBA_fnc_waitUntilAndExecute;

    // Cache current channel to switch back to on exit
    ace_spectator_channelCache = currentChannel;

    // Channel index starts count after the 5 default channels
    ace_spectator_channel radioChannelAdd [player];
    setCurrentChannel (5 + ace_spectator_channel);

    // Cache and disable nametag settings
    if (["ace_nametags"] call ace_common_fnc_isModLoaded) then {
        ace_spectator_nametagSettingCache = [ace_nametags_showPlayerNames, ace_nametags_showNamesForAI];
        ace_nametags_showPlayerNames = 0;
        ace_nametags_showNamesForAI = false;
    };
} else {
    // Kill the display (ensure main display exists, handles edge case where spectator turned off beforehand)
    [{ !isNull MAIN_DISPLAY },{ [false] call ace_spectator_fnc_ui }] call CBA_fnc_waitUntilAndExecute;

    // This variable doesn't matter anymore
    ace_spectator_uiForced = nil;

    // Terminate camera
    [false] call ace_spectator_fnc_cam;

    // Remove from spectator chat
    ace_spectator_channel radioChannelRemove [player];

    // Restore cached channel and delete cache
    setCurrentChannel ace_spectator_channelCache;
    ace_spectator_channelCache = nil;

    // Reset nametag settings
    if (["ace_nametags"] call ace_common_fnc_isModLoaded) then {
        ace_nametags_showPlayerNames = ace_spectator_nametagSettingCache select 0;
        ace_nametags_showNamesForAI = ace_spectator_nametagSettingCache select 1;
        ace_spectator_nametagSettingCache = nil;
    };

    [] call ace_common_fnc_showHud;
};

// Hide/Unhide the player if enabled and alive
if (alive player) then {
    private _hidden = (_hide && _set);
    TRACE_1("",_hidden);

    // Ignore damage (vanilla and ace_medical)
    player allowDamage !_hidden;
    player setVariable ["ace_medical_allowDamage", !_hidden];

	// EFN: nope
    // Move to/from group as appropriate
    //[player, _hidden, "ace_spectator_isSet", side group player] call ace_common_fnc_switchToGroupSide;

    // Ghosts can't talk
    if (_hidden) then {
        [player, "ace_spectator_isSet"] call ace_common_fnc_hideUnit;
        [player, "ace_spectator_isSet"] call ace_common_fnc_muteUnit;
    } else {
        [player, "ace_spectator_isSet"] call ace_common_fnc_unhideUnit;
        [player, "ace_spectator_isSet"] call ace_common_fnc_unmuteUnit;
    };
};

// Reset interruptions
ace_spectator_interrupts = [];

// Mark spectator state for reference
ace_spectator_isSet = _set;
player setVariable ["ace_spectator_isSet", _set, true];

["ace_spectatorSet", [_set, player]] call CBA_fnc_globalEvent;