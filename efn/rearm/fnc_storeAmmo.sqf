#include "script_component.hpp"
/*
 * Author: GitHawk
 * Modified from ACE by Eclipser
 * Stores ammo in an ammo truck.
 *
 * Arguments:
 * 0: Ammo Truck <OBJECT>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ammo_truck, player] call efn_rearm_fnc_storeAmmo
 *
 * Public: No
 */

params ["_truck", "_unit"];

private _attachedDummy = _unit getVariable ["ace_rearm_dummy", objNull];
if (isNull _attachedDummy) exitwith {};

private _magazineClass = _attachedDummy getVariable ["ace_rearm_magazineClass", "#noVar"];

[
    TIME_PROGRESSBAR(5),
    [_unit, _truck, _attachedDummy],
    {
        params ["_args"];
        _args params ["_unit", "_truck", "_attachedDummy"];
        [_truck, (_attachedDummy getVariable ["ace_rearm_magazineClass", ""]), true] call FUNC(addMagazineToSupply);
        [_unit, true, true] call ace_rearm_fnc_dropAmmo;
    },
    "",
    format [localize "STR_ACE_Rearm_StoreAmmoAction", _magazineClass call ace_rearm_fnc_getMagazineName, getText(configOf _truck >> "displayName")],
    {true},
    ["isnotinside"]
] call ace_common_fnc_progressBar;
