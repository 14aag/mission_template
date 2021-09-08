#include "script_component.hpp"
params ["", "_unit"];

if (isNull _unit) exitWith {
    ["STR_Zen_Modules_NoUnitSelected"] call zen_common_fnc_showMessage;
};

if !(_unit isKindOf "CAManBase") exitWith {
    ["STR_Zen_Modules_OnlyInfantry"] call zen_common_fnc_showMessage;
};

if !(alive _unit) exitWith {
    ["STR_Zen_Modules_OnlyAlive"] call zen_common_fnc_showMessage;
};

private _params = [
    [
        "TOOLBOX",
        "STR_Zen_Common_Target",
        [true, 1, 2, ["STR_Zen_Common_SelectedUnit", "STR_Zen_Common_SelectedGroup"]]
    ]
];
private _title = "Reveal";
private _isUndercover = (group _unit) getVariable [QGVAR(isUndercover), false];

if !(_isUndercover) then {
    _title = "Undercover";
    private _defaultSides = [side _unit] call FUNC(getEnemySides);
    _params pushBack ["SIDES", "Spotting sides", [_defaultSides]]
};

[_title, _params, {
    params ["_values", "_params"];
    _values params ["_entireGroup", "_sides"];
    _params params ["_unit", "_isUndercover"];

    if (_isUndercover) then {
        [_unit, false, _entireGroup] call FUNC(setUndercover);
    } else {
        [_unit, true, _entireGroup, _sides] call FUNC(setUndercover);
    };
}, {}, [_unit, _isUndercover]] call zen_dialog_fnc_create;
