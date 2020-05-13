#include "script_component.hpp"

if (!hasInterface) exitWith {};
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
