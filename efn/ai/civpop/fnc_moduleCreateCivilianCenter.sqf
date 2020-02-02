#include "script_component.hpp"
params ["_pos", ""];

["Create civilian center",[
    ["SLIDER", "Size", [25, 300, 100, 0]],
    ["SLIDER", "Amount", [1, 50, 15, 0]],
    ["COMBO", "Preset", [["altis", "workers", "takistan"], ["Altis", "Workers", "Takistan"], 0]]
], {
    params ["_dialogValues", "_pos"];
    _dialogValues params ["_size", "_amount", "_preset"];

    if (isNil QGVAR(logicGroup)) then {
        GVAR(logicGroup) = createGroup sideLogic;
    };
    private _logic = GVAR(logicGroup) createUnit ["Logic", _pos, [], 0, "CAN_COLLIDE"];
    [_logic, _size, _size, _preset, _amount] call FUNC(init);
}, {}, _pos] call zen_dialog_fnc_create;
