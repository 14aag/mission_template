#include "script_component.hpp"
params ["_vehicle", "_item"];

private _displayName = getText (configfile >> "CfgVehicles" >> typeOf _item >> "displayName");
[
    5,
    [_vehicle, _item],
    {
        (_this select 0) call FUNC(unloadCargo);
    },
    {},
    format ["Unloading %1", _displayName],
    {
        (_this select 0) params ["_target"];
        TRACE_1("",_this);
        locked _target < 2 &&
        {([ace_player, _target] call ace_interaction_fnc_getInteractionDistance) < MAX_LOAD_DISTANCE} &&
        {alive _target} &&
        {[_target] call FUNC(isCargoLoaded)}
    },
    ["IsNotSwimming"]
] call ACE_common_fnc_progressBar;
