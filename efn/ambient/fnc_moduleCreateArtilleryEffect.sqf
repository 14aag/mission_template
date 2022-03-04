#include "script_component.hpp"
params ["_pos", ""];

["Artillery", [
    ["SLIDER", "Range", [0, 1000, 0, 0]]
], {
    params ["_dialogValues", "_pos"];
    _dialogValues params ["_range"];

    [QGVAR(initArtillery), [_pos, _range]] call CBA_fnc_serverEvent;
}, {}, _pos] call zen_dialog_fnc_create;
