#include "script_component.hpp"
/*
 * Author: GitHawk
 * Modified from ACE by Eclipser
 * Get the remaining ammunition amount.
 *
 * Arguments:
 * 0: Ammo Truck <OBJECT>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ammo_truck, player] call efn_rearm_fnc_readSupplyCounter
 *
 * Public: No
 */

params ["_truck", "_unit"];
TRACE_2("readSupplyCounter",_truck,_unit);

[
    TIME_PROGRESSBAR(5),
    [_unit, _truck],
    {
        params ["_args"];
        _args params [["_unit", objNull, [objNull]], ["_truck", objNull, [objNull]]];
        private _supply = 1.5;
        private _numChars = count (localize "STR_ACE_Rearm_Hint_RemainingAmmo");
        private _text = "";
        private _magazines = _truck getVariable "ace_rearm_magazineSupply";
        if (!isNil "_magazines") then {
            {
                _x params ["_magazineClass", "_rounds"];
                private _line = format ["%1: %2", _magazineClass call ace_rearm_fnc_getMagazineName, _rounds];
                _numChars = _numChars max (count _line);
                _text = format ["%1<br/>%2", _text, _line];
                _supply = _supply + 0.5;
                false
            } count _magazines;
        };
        if (_supply > 1.5) then {
            [["STR_ACE_Rearm_Hint_RemainingAmmo", _text], _supply, _unit, (_numChars/2.9)] call ace_common_fnc_displayTextStructured;
        } else {
            ["STR_ACE_Rearm_Hint_Empty", 2, _unit] call ace_common_fnc_displayTextStructured;
        };
        true
    },
    {true},
    localize "STR_ACE_Rearm_ReadSupplyCounterAction",
    {true},
    ["isnotinside"]
] call ace_common_fnc_progressBar;
