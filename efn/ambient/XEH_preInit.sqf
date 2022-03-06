#include "script_component.hpp"
#include "XEH_PREP.hpp"

if (isServer) then {
    [QGVAR(initTracers), FUNC(createTracerEffect)] call CBA_fnc_addEventHandler;
    [QGVAR(initArtillery), FUNC(createArtilleryEffect)] call CBA_fnc_addEventHandler;
};
if (hasInterface) then {
    ["14 AAG Effects", "Tracers", FUNC(moduleCreateTracerEffect)] call zen_custom_modules_fnc_register;
    ["14 AAG Effects", "Artillery", FUNC(moduleCreateArtilleryEffect)] call zen_custom_modules_fnc_register;
};

GVAR(mortarSoundsDist) = [];
{
    if (isClass (missionConfigFile >> "CfgSounds" >> _x)) then {
        GVAR(mortarSoundsDist) pushBack _x;
    };
} forEach [QGVAR(mortar_dist1), QGVAR(mortar_dist2), QGVAR(mortar_dist3), QGVAR(mortar_dist4)];

GVAR(mortarSoundsMid) = [];
{
    if (isClass (missionConfigFile >> "CfgSounds" >> _x)) then {
        GVAR(mortarSoundsMid) pushBack _x;
    };
} forEach [QGVAR(mortar_mid1), QGVAR(mortar_mid2), QGVAR(mortar_mid3), QGVAR(mortar_mid4)];

GVAR(tracerSounds) = [];
{
    if (isClass (missionConfigFile >> "CfgSounds" >> _x)) then {
        GVAR(tracerSounds) pushBack _x;
    };
} forEach [QGVAR(tracer_dist1), QGVAR(tracer_dist2), QGVAR(tracer_dist3), QGVAR(tracer_dist4)];

GVAR(effects) = [];
GVAR(stateMachine) = [{
    GVAR(effects) - [objNull]
}] call CBA_statemachine_fnc_create;

[GVAR(stateMachine), {}, {}, {}, "idle"] call CBA_statemachine_fnc_addState;
[GVAR(stateMachine), {
    private _nextRun = _this getVariable [QGVAR(nextRun), 0];
    if (_nextRun > CBA_missionTime) exitWith {};

    private _params = _this getVariable QGVAR(params);
    private _run = _this getVariable QGVAR(run);

    private _delay = [_this, _params] call _run;
    _this setVariable [QGVAR(nextRun), (CBA_missionTime + _delay)];
}, {}, {}, "active"] call CBA_statemachine_fnc_addState;

[GVAR(stateMachine), "idle", "active", {
    private _distance = ACE_player distance2D _this;
    _distance < 2000 && _distance > 300;
}] call CBA_statemachine_fnc_addTransition;

[GVAR(stateMachine), "active", "idle", {
    private _distance = ACE_player distance2D _this;
    _distance < 300 || _distance > 2000;
}] call CBA_statemachine_fnc_addTransition;
