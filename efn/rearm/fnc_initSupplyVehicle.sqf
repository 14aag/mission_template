#include "script_component.hpp"
/*
 * Author: Githawk, PabstMirror
 * Modified from ACE by Eclipser
 * Adds rearm supply actions to a vehicle or ammo container.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ammoTruck] call efn_rearm_fnc_initSupplyVehicle;
 *
 * Public: No
 */

if (!hasInterface) exitWith {}; // For now we just add actions, so no need non-clients

params ["_vehicle"];
private _typeOf = typeOf _vehicle;
TRACE_2("initSupplyVehicle",_vehicle,_typeOf);

if (!alive _vehicle) exitWith {};

private _actionReadSupplyCounter = [ // GVAR(supply) > 0
    QGVAR(ReadSupplyCounter),
    localize "STR_ACE_Rearm_ReadSupplyCounter", // Check remaining ammunition
    "z\ace\addons\rearm\ui\icon_rearm_interact.paa",
    {_this call FUNC(readSupplyCounter)},
    {_this call FUNC(canReadSupplyCounter)}
] call ace_interact_menu_fnc_createAction;

private _actionTakeAmmo = [
    QGVAR(takeAmmo),
    localize "STR_ACE_Rearm_TakeAmmo",
    "\z\ace\addons\rearm\ui\icon_rearm_interact.paa",
    {},
    {_this call FUNC(canTakeAmmo)},
    {_this call FUNC(addRearmActions)}
] call ace_interact_menu_fnc_createAction;

private _actionStoreAmmo = [
    QGVAR(StoreAmmo),
    localize "STR_ACE_Rearm_StoreAmmo", // "Store ammo"
    "\z\ace\addons\rearm\ui\icon_rearm_interact.paa",
    {_this call FUNC(storeAmmo)},
    {_this call FUNC(canStoreAmmo)}
] call ace_interact_menu_fnc_createAction;

private _actionPickup = [
    QGVAR(Pickup),
    "Pickup container",
    "",
    {_this call FUNC(pickup)},
    {_this call FUNC(canPickup)}
] call ace_interact_menu_fnc_createAction;

if (_vehicle getVariable ["ace_rearm_objectActionsAdded", false]) exitWith {TRACE_1("Actions already added to object",_vehicle);};
_vehicle setVariable ["ace_rearm_objectActionsAdded", true];
TRACE_1("Adding Object Actions",_typeOf);
[_vehicle, 0, ["ACE_MainActions"], _actionReadSupplyCounter] call ace_interact_menu_fnc_addActionToObject;
[_vehicle, 0, ["ACE_MainActions"], _actionTakeAmmo] call ace_interact_menu_fnc_addActionToObject;
[_vehicle, 0, ["ACE_MainActions"], _actionStoreAmmo] call ace_interact_menu_fnc_addActionToObject;
[_vehicle, 0, ["ACE_MainActions"], _actionPickup] call ace_interact_menu_fnc_addActionToObject;
