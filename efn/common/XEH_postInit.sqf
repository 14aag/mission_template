#include "script_component.hpp"

if (!hasInterface) exitWith {};
GVAR(missionStartTime) = getMissionConfigValue [QGVAR(missionStartTime), 0];
GVAR(disabledChannels) = [0, 1];

{
    _x enableChannel [false, false];
} forEach GVAR(disabledChannels);

[missionNamespace, "Map", {
    params ["_open", ""];

    {
        _x enableChannel [false, _open]; // enable VON on map to allow markers on these channels
    } forEach GVAR(disabledChannels);
}] call CBA_fnc_addBISEventHandler;

["unit", FUNC(setupMoveToLeader), true] call CBA_fnc_addPlayerEventHandler;
