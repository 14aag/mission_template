#include "script_component.hpp"
params ["_cargo", "_storage"];

if (isNil "_cargo" || {!(_cargo isEqualType [])}) exitWith {};
if (!hasInterface) exitWith {};

private _loadAction = [
    QGVAR(loadAction), "Store Vehicle", "",
    {
        params ["_target", "_player", "_storage"];
        [_storage, _target] call FUNC(startLoadCargo);
    },
    {
        params ["_target", "_player", "_storage"];
        (_storage getVariable [QGVAR(hasCargo), false]) &&
        {locked _storage < 2} &&
        {([_player, _target] call ace_interaction_fnc_getInteractionDistance) < MAX_LOAD_DISTANCE} &&
        {alive _target} &&
        {alive _storage} &&
        {!isEngineOn _target} &&
        {(crew _target) isEqualTo []} &&
        {[_player, _target, ["isNotSwimming"]] call ace_common_fnc_canInteractWith} &&
        {_target distance _storage < ((sizeOf typeOf _target) + MAX_LOAD_DISTANCE)} &&
        {[_target, _storage] call FUNC(canLoadCargo)}
    },
    {},
    _storage
] call ace_interact_menu_fnc_createAction;

{
    if (isNull _x) then {continue};
    if !(_x getVariable [QGVAR(initCargo), false]) then {
        _x setVariable [QGVAR(initCargo), true];
        [_x, 0, ["ACE_MainActions"], _loadAction] call ace_interact_menu_fnc_addActionToObject;
    };
} forEach _cargo;
