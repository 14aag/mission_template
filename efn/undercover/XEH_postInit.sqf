#include "script_component.hpp"

if (!hasInterface) exitWith {};

[player, "respawn", {
    params ["_unit", "_corpse"];
    if (!isNil QEGVAR(respawn,position) && !isNull EGVAR(respawn,position)) exitWith {};
    if ((group _unit) getVariable [QGVAR(isUndercover), false]) then {
        private _side = (group _unit) getVariable [QGVAR(originalSide), sideUnknown];
        private _markerName = switch (_side) do {
            case west: { "respawn_west" };
            case east: { "respawn_east" };
            case independent: { "respawn_guerrila" };
            case civilian: { "respawn_civilian" };
            default { "respawn" };
        };
        if (_markerName in allMapMarkers) then {
            private _pos = getMarkerPos [_markerName, true];
            _unit setPosASL _pos;
        };
    };
}] call CBA_fnc_addBISEventHandler;
