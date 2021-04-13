#include "script_component.hpp"
/*
 * Author: GitHawk
 * Modified from ACE by Eclipser
 * Checks if unit can read supply counter. [Only for GVAR(supply) > 0]
 *
 * Arguments:
 * 0: Ammo Truck <OBJECT>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * Can read supply counter <BOOL>
 *
 * Example:
 * [ammo_truck, player] call efn_rearm_fnc_canReadSupplyCounter
 *
 * Public: No
 */

params ["_truck", "_unit"];

(alive _unit)
&& {alive _truck}
&& {(_truck distance _unit) < REARM_ACTION_DISTANCE}
&& {[_unit, _truck, ["IsNotInside"]] call ace_common_fnc_canInteractWith} // manually added actions need this
&& {(_truck getVariable [QGVAR(currentSupply), 0]) >= 0}
