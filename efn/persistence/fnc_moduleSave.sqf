#include "script_component.hpp"

[
    "Save mission",
    [
        ["CHECKBOX", "Save also locally?", true, false]
    ],
    {
        params ["_dialogValues"];
        _dialogValues params ["_saveLocal"];
        [QGVAR(force_save)] call CBA_fnc_serverEvent;
        if (_saveLocal) then {
            [player, format ["%1.%2", missionName, worldName]] remoteExecCall [QFUNC(fetchState), 2];
        };
    }
] call zen_dialog_fnc_create;
