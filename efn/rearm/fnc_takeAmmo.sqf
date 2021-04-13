#include "script_component.hpp"
/*
 * Author: GitHawk
 * Modified from ACE by Eclipser
 * Starts progress bar for picking up a specific kind of magazine from an ammo truck.
 *
 * Arguments:
 * 0: Ammo Truck <OBJECT>
 * 1: Unit <OBJECT>
 * 2: Params <ARRAY>
 *   0: Magazine Classname <STRING>
 *   1: Vehicle to be armed or player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ammo_truck, player, ["500Rnd_127x99_mag_Tracer_Red", tank]] call efn_rearm_fnc_takeAmmo
 *
 * Public: No
 */

params ["_truck", "_unit", "_args"];
_args params ["_magazineClass", "_vehicle"];
TRACE_5("takeAmmo",_truck,_unit,_args,_magazineClass,_vehicle);

([_magazineClass] call ace_rearm_fnc_getCaliber) params ["_cal", "_idx"];

REARM_HOLSTER_WEAPON;

private _targetName = if (_vehicle == _unit) then {
    "CSW"
} else {
    getText(configOf _vehicle >> "displayName")
};

[
    TIME_PROGRESSBAR(REARM_DURATION_TAKE select _idx),
    [_unit, _magazineClass, _truck, _vehicle],
    FUNC(takeSuccess),
    "",
    format [localize "STR_ACE_Rearm_TakeAction", _magazineClass call ace_rearm_fnc_getMagazineName, _targetName],
    {true},
    ["isnotinside"]
] call ace_common_fnc_progressBar;
