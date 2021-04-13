#include "script_component.hpp"
/*
 * Author: GitHawk
 * Modified from ACE by Eclipser
 * Removes a magazine from the supply.
 *
 * Arguments:
 * 0: Ammo Truck <OBJECT>
 * 1: Magazine Classname <STRING>
 * 2: Number of Rounds to withdraw <NUMBER> (default: -1)
 *
 * Return Value:
 * Magazine was removed <BOOL>
 *
 * Example:
 * [ammo_truck, "500Rnd_127x99_mag_Tracer_Red"] call efn_rearm_fnc_removeMagazineFromSupply
 *
 * Public: Yes
 */

params [["_truck", objNull, [objNull]], ["_magazineClass", "", [""]], ["_numRounds", -1, [0]]];
TRACE_3("removeMagazineFromSupply",_truck,_magazineClass,_numRounds);

if (isNull _truck || {_magazineClass isEqualTo ""}) exitWith {false};

private _return = false;
([_magazineClass] call ace_rearm_fnc_getCaliber) params ["_cal", "_idx"];

private _magazineSupply = _truck getVariable ["ace_rearm_magazineSupply", []];
private _magazineIdx = -1;
{
    _x params ["_magazine"];
    if (_magazine isEqualTo _magazineClass) exitWith {
        _magazineIdx = _forEachIndex;
    };
} forEach _magazineSupply;
if (_magazineIdx == -1) exitWith {false};

(_magazineSupply select _magazineIdx) params ["", "_rounds"];

private _configRounds = getNumber (configFile >> "CfgMagazines" >> _magazineClass >> "count");
// Remove entire magazine
if (_rounds >= _configRounds) then {
    _magazineSupply set [_magazineIdx, [_magazineClass, (_rounds - _configRounds)]];
    _truck setVariable ["ace_rearm_magazineSupply", _magazineSupply, true];
    _return = true;
};
_return
