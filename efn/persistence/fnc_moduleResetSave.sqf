#include "script_component.hpp"

[
    "Reset save",
    [
        ["CHECKBOX", "End mission", true, false]
    ],
    {
        params ["_dialogValues"];
        _dialogValues params ["_endMission"];
        [_endMission] remoteExecCall [QFUNC(resetCurrent), 2];
    }
] call zen_dialog_fnc_create;
