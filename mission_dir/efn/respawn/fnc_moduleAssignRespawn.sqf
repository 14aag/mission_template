#include "script_component.hpp"
params ["", "_object"];

if (!isPlayer _object) exitWith {
    ["Place on player"] call zen_common_fnc_showMessage;
};

["Assign Respawn", [["EDIT", "Name", (group _object) getVariable ["leader_name", ""]]], {
    params ["_dialogValues", "_object"];
    _dialogValues params ["_name"];
    (group _object) setVariable ["leader_name", _name, true];
    [QGVAR(force_leader_name_update)] call CBA_fnc_globalEvent;
}, {}, _object] call zen_dialog_fnc_create;
