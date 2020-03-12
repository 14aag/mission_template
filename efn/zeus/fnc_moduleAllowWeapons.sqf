#include "script_component.hpp"

["Allow Weapons", [
    ["TOOLBOX:YESNO", "Allow Weapons", (player getVariable [QEGVAR(common,disableWeaponsReasons), []]) find "zeus" != -1, false]
], {
    params ["_dialogValues"];
    _dialogValues params ["_allow"];

    [QEGVAR(common,disableWeapons), [!_allow, "zeus"]] call CBA_fnc_globalEvent;
}] call zen_dialog_fnc_create;
