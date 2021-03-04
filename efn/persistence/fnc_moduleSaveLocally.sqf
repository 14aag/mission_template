#include "script_component.hpp"

[
    "Choose mission",
    [
        ["EDIT", "PBO Name", "", false]
    ],
    {
        params ["_dialogValues"];
        _dialogValues params ["_name"];
        [player, _name] remoteExecCall [QFUNC(fetchState), 2];
    }
] call zen_dialog_fnc_create;
