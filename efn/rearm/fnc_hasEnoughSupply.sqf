#include "script_component.hpp"
/*
 * Author: GitHawk
 * Modified from ACE by Eclipser
 * Check whether enough supply is left to take the magazine.
 *
 * Arguments:
 * 0: Ammo Truck <OBJECT>
 * 1: Magazine Classname <STRING>
 *
 * Return Value:
 * Enough supply <BOOL>
 *
 * Example:
 * [ammo_truck, "500Rnd_127x99_mag_Tracer_Red"] call efn_rearm_fnc_hasEnoughSupply
 *
 * Public: No
 */

params ["_truck", "_magazineClass"];

private _magazineSupply = _truck getVariable ["ace_rearm_magazineSupply", []];
private _magazinePresent = false;
{
    _x params ["_magazine", "_rounds"];
    if ((_magazine isEqualTo _magazineClass) && (_rounds > 0)) exitWith {_magazinePresent = true; };
    false
} count _magazineSupply;
_magazinePresent
