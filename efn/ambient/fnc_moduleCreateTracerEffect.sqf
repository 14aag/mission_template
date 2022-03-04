#include "script_component.hpp"
params ["_pos", ""];

["Tracers",[
    ["COMBO", "Color", [["red", "green", "yellow"], ["Red", "Green", "Yellow"], 0]],
    ["SLIDER", "Firing Direction", [0, 360, 0, 0]],
    ["SLIDER", "Firing Direction +/-", [0, 360, 0, 0]],
    ["SLIDER", "Firing Angle", [0, 180, 0, 0]],
    ["SLIDER", "Firing Angle +/-", [0, 360, 0, 0]],
    ["SLIDER", "Muzzle velocity", [0, 1500, 400, 0]],
    ["SLIDER", "Muzzle velocity +/-", [0, 1500, 50, 0]],
    ["SLIDER", "Size", [0, 1500, 50, 0]]
], {
    params ["_dialogValues", "_pos"];
    _dialogValues params ["_color", "_dir", "_dirVar", "_angle", "_angleVar", "_velocity", "_velocityVar", "_size"];

    [QGVAR(initTracers), [_pos, _color, [_dir, _dirVar], [_angle, _angleVar], [_velocity, _velocityVar], _size]] call CBA_fnc_serverEvent;
}, {}, _pos] call zen_dialog_fnc_create;
