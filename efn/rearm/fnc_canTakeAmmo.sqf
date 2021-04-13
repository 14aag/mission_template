#include "script_component.hpp"
/*
 * Author: GitHawk
 * Modified from ACE by Eclipser
 * Check if a unit can pick up ammo.
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * Can Pick Up Ammo <BOOL>
 *
 * Example:
 * [ammo_truck, player] call efn_rearm_fnc_canTakeAmmo
 *
 * Public: No
 */

params ["_truck", "_unit"];

(alive _unit)
&& {alive _truck}
&& {(_truck distance _unit) < REARM_ACTION_DISTANCE}
&& {isNull (_unit getVariable ["ace_rearm_dummy", objNull])}
&& {[_unit, _truck, ["IsNotInside"]] call ace_common_fnc_canInteractWith} // manually added actions need this
&& {(_truck getVariable [QGVAR(currentSupply), 0]) >= 0}
