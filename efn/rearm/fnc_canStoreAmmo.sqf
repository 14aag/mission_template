#include "script_component.hpp"
/*
 * Author: GitHawk
 * Modified from ACE by Eclipser
 * Check if a unit can store ammo in an ammo truck.
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * Can Store Ammo <BOOL>
 *
 * Example:
 * [ammo_truck, player] call efn_rearm_fnc_canStoreAmmo
 *
 * Public: No
 */

params ["_truck", "_unit"];
   
(alive _unit)
&& {!isNull (_unit getVariable ["ace_rearm_dummy", objNull])}
&& {alive _truck}
&& {(_truck distance _unit) < REARM_ACTION_DISTANCE}
&& {[_unit, _truck, ["IsNotInside"]] call ace_common_fnc_canInteractWith} // manually added actions need this
&& {(_truck getVariable [QGVAR(currentSupply), 0]) >= 0}
