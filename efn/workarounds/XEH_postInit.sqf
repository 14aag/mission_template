#include "script_component.hpp"

// free people form unconscious animation when they're not actually unconscious
["CAManBase", "AnimDone", {
    params ["_unit", "_anim"];
    if (!alive _unit || {!local _unit || {!(_anim isEqualTo "unconscious") || {_unit getVariable ["ACE_isUnconscious", false] || {lifeState _unit == "INCAPACITATED"}}}}) exitWith {};
    [_unit, false] call ace_medical_engine_fnc_setUnconsciousAnim;
}, true, [], true] call CBA_fnc_addClassEventHandler;

["ace_medical_injured", FUNC(updateDamage)] call CBA_fnc_addEventHandler;
["ace_medical_treatment_bandageLocal", FUNC(updateDamage)] call CBA_fnc_addEventHandler;
["ace_medical_treatment_splintLocal", FUNC(updateDamage)] call CBA_fnc_addEventHandler;
["ace_medical_treatment_fullHealLocal", FUNC(updateDamage)] call CBA_fnc_addEventHandler;

if (hasInterface) then {
    [player, "killed", {
        ["unconscious", false] call ace_common_fnc_setDisableUserInputStatus;
    }] call CBA_fnc_addBISEventHandler;

    [player, "respawn", {
        params ["_unit"];
        if !(local _unit) then {
            private _text = text format ['[EFN] (workarounds) INFO: Unit not local: %1', name player];
            [_text] remoteExec ["diag_log", 2];
        };
        [_unit, ace_medical_state_machine, "Dead", "Default"] call CBA_statemachine_fnc_manualTransition;

        if ((ace_common_localUnits find _unit) == -1) then {
            private _text = text format ['[EFN] (workarounds) INFO: Unit not in localUnits: %1', name player];
            [_text] remoteExec ["diag_log", 2];
        };
        ace_common_localUnits pushBackUnique _unit;
    }] call CBA_fnc_addBISEventHandler;
};

// Apparently groups just stop if their leader has binocs out in not combat mode... (lambs danger fix)
[{
    private _groups = allGroups;
    private _binocUser = _groups findIf {
        private _leader = leader _x;
        local _leader &&
        {!(isPlayer _leader) &&
        {(behaviour _leader) in ["CARELESS", "SAFE", "AWARE"] &&
        {(currentWeapon _leader) isEqualTo (binocular _leader)}}}
    };
    if (_binocUser != -1) then {
        private _leader = leader (_groups select _binocUser);
        private _weapon = primaryWeapon _leader;
        if (_weapon isEqualTo "") then {
            _weapon = secondaryWeapon _leader;
        };
        if !(_weapon isEqualTo "") then {
            _leader selectWeapon _weapon;
        };
    };
}, 5] call CBA_fnc_addPerFrameHandler;

// Keep people muted when dead, ACE will unmute them when they respawn
["ace_medical_death", {
    params ["_unit"];
    if (_unit != ACE_player) exitWith {};
    [false, _unit] call ace_common_fnc_setVolume;
}] call CBA_fnc_addEventHandler;
