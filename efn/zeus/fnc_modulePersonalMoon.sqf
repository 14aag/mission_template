#include "script_component.hpp"
params ["_pos", ""];

["Personal Moon", [
    ["SLIDER", "Brightness", [0, 1000, EGVAR(common,personalMoonBrightness), 0]],
    ["COLOR", "Color", EGVAR(common,personalMoonColor)]
], {
    params ["_dialogValues", "_pos"];
    _dialogValues params ["_brightness", "_color"];

    [QEGVAR(common,configurePersonalMoon), [_brightness, _color], QGVAR(personalMoonJIP)] call CBA_fnc_globalEventJIP;
}, {}, _pos] call zen_dialog_fnc_create;
