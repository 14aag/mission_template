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
        ace_common_localUnits pushBackUnique _unit;
    }] call CBA_fnc_addBISEventHandler;
};