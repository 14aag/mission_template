#include "script_component.hpp"
params ["", "_unit"];

if (isNull _unit || !isPlayer _unit) exitWith {
	["Must be placed on a player"] call zen_common_fnc_showMessage;
};

["Forbid Looting", [
    ["TOOLBOX:YESNO", "Forbid Looting", !(player getVariable [QEGVAR(inventory,lootingForbidden), false]), false]
], {
    params ["_dialogValues", "_unit"];
    _dialogValues params ["_forbid"];

    [QEGVAR(inventory,forbidLooting), [_forbid], _unit] call CBA_fnc_targetEvent;
}, {}, _unit] call zen_dialog_fnc_create;
