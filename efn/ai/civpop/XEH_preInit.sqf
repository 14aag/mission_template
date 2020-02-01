#include "script_component.hpp"
#include "XEH_PREP.hpp"

if (!isServer) exitWith {};

GVAR(centers) = [];
GVAR(stateMachine) = [GVAR(centers)] call CBA_statemachine_fnc_create;

[GVAR(stateMachine), {}, {}, {}, "idle"] call CBA_statemachine_fnc_addState;
[GVAR(stateMachine), FUNC(handleStateSpawn), FUNC(enteredStateSpawn), {}, "spawn"] call CBA_statemachine_fnc_addState;
[GVAR(stateMachine), {}, {}, FUNC(leftStateActive), "active"] call CBA_statemachine_fnc_addState;

[GVAR(stateMachine), "idle", "spawn", FUNC(conditionActivate)] call CBA_statemachine_fnc_addTransition;
[GVAR(stateMachine), "spawn", "active", {
    (count (_this getVariable [QGVAR(units), []])) >= (_this getVariable [QGVAR(count), 15]);
}] call CBA_statemachine_fnc_addTransition;
[GVAR(stateMachine), "active", "idle", FUNC(conditionDeactivate)] call CBA_statemachine_fnc_addTransition;

GVAR(civilians) = [];
GVAR(civilianStateMachine) = [GVAR(civilians)] call CBA_statemachine_fnc_create;

[GVAR(civilianStateMachine), FUNC(handleStateCivilianCalm), FUNC(enteredStateCivilianCalm), {}, "calm"] call CBA_statemachine_fnc_addState;
[GVAR(civilianStateMachine), FUNC(handleStateCivilianPanic), FUNC(enteredStateCivilianPanic), {}, "panic"] call CBA_statemachine_fnc_addState;

[GVAR(civilianStateMachine), "calm", "panic", [QGVAR(firedNear)]] call CBA_statemachine_fnc_addEventTransition;
[GVAR(civilianStateMachine), "panic", "calm", FUNC(conditionCivilianPanic)] call CBA_statemachine_fnc_addTransition;
