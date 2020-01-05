#include "script_component.hpp"

// free people form unconscious animation when they're not actually unconscious
["CAManBase", "AnimDone", {
    params ["_unit", "_anim"];
    if (!alive _unit || {!local _unit || {!(_anim isEqualTo "unconscious") || {_unit getVariable ["ACE_isUnconscious", false] || {lifeState _unit == "INCAPACITATED"}}}}) exitWith {};
    [_unit, false] call ace_medical_engine_fnc_setUnconsciousAnim;
}, true, [], true] call CBA_fnc_addClassEventHandler;

if (hasInterface) then {
    [player, "killed", {
        ["unconscious", false] call ace_common_fnc_setDisableUserInputStatus;
    }] call CBA_fnc_addBISEventHandler;
};