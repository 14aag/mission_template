#include "script_component.hpp"
/*
 * Author: GitHawk
 * Modified from ACE by Eclipser
 * Adds magazines to the supply. [Global Effects]
 *
 * Arguments:
 * 0: Ammo Truck <OBJECT>
 * 1: Magazine Classname <STRING>
 * 2: Only partial <BOOL> (default: false)
 *
 * Return Value:
 * None
 *
 * Example:
 * [ammo_truck, "32Rnd_155mm_Mo_shells"] call efn_rearm_fnc_addMagazineToSupply
 *
 * Public: Yes
 */

params [["_truck", objNull, [objNull]], ["_magazineClass", "", [""]], ["_partial", false, [false]]];
TRACE_3("addMagazineToSupply",_truck,_magazineClass,_partial);

if (isNull _truck || {_magazineClass isEqualTo ""}) exitWith {};

([_magazineClass] call ace_rearm_fnc_getCaliber) params ["_cal", "_idx"];

private _magazineSupply = _truck getVariable ["ace_rearm_magazineSupply", []];
private _magazineIdx = -1;
{
    _x params ["_magazine", "_rounds"];
    if (_magazine isEqualTo _magazineClass) exitWith {
        _magazineIdx = _forEachIndex;
    };
} forEach _magazineSupply;

private _roundsPerTransaction = getNumber (configFile >> "CfgMagazines" >> _magazineClass >> "count");
if (_partial) then {
    _roundsPerTransaction = _roundsPerTransaction min (REARM_COUNT select _idx);
};
if (_magazineIdx == -1) then {
    if (_magazineSupply isEqualTo []) then {
        _magazineSupply = [[_magazineClass, _roundsPerTransaction]];
    } else {
        _magazineSupply append [[_magazineClass, _roundsPerTransaction]];
    }
} else {
    (_magazineSupply select _magazineIdx) params ["", "_rounds"];
    _magazineSupply set [_magazineIdx, [_magazineClass, (_rounds + _roundsPerTransaction)]];
};
_truck setVariable ["ace_rearm_magazineSupply", _magazineSupply, true];
