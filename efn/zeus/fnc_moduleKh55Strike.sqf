#include "script_component.hpp"
params ["_pos", ""];

["KH-55", [
    ["SLIDER", "Launch Distance", [0, 10000, 2500, 0]],
    ["SLIDER", "Launch Altitude", [800, 5000, 2500, 0]],
    ["COMBO", "Launch Direction", [[0, 45, 90, 135, 180, 225, 270, 315], ["N", "NE", "E", "SE", "S", "SW", "W", "NW"], 0]]
], {
    params ["_dialogValues", "_pos"];
    _dialogValues params ["_distance", "_altitude", "_direction"];

    [QGVAR(kh55Strike), [_pos, _distance, _altitude, _direction]] call CBA_fnc_serverEvent;
}, {}, _pos] call zen_dialog_fnc_create;

