#include "script_component.hpp"
params ["_vehicle", "_item"];

private _displayName = getText (configfile >> "CfgVehicles" >> typeOf _item >> "displayName");
[
    5,
    [_vehicle, _item],
    {
        [QGVAR(loadCargo), (_this select 0)] call CBA_fnc_serverEvent;
    },
    {},
    format ["Storing %1", _displayName],
    {
        (_this select 0) params ["_vehicle", "_target"];
        TRACE_1("",_this);
        locked _target < 2 &&
        {alive _target} &&
        {alive _vehicle} &&
        {!isEngineOn _target} &&
        {(crew _target) isEqualTo []} &&
        {([ace_player, _target] call ace_interaction_fnc_getInteractionDistance) < MAX_LOAD_DISTANCE} &&
		{[_target, _vehicle] call FUNC(canLoadCargo)}
    },
    ["IsNotSwimming"]
] call ACE_common_fnc_progressBar;
