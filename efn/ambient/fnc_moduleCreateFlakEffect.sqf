#include "script_component.hpp"
params ["_pos", ""];

["Flak", [
    ["SLIDER", "Radius", [0, 1000, 0, 0]],
    ["SLIDER", "Height +/-", [0, 1000, 0, 0]]
], {
    params ["_dialogValues", "_pos"];
    _dialogValues params ["_radius", "_heightVar"];

    [QGVAR(initFlak), [_pos, _radius, _heightVar]] call CBA_fnc_serverEvent;
}, {}, _pos] call zen_dialog_fnc_create;

