#include "script_component.hpp"
params ["_pos", ""];

["Create civilian center",[
    ["SLIDER", "Size", [25, 300, 100, 0]],
    ["SLIDER", "Amount", [1, 50, 15, 0]],
    ["COMBO", "Preset", [["altis", "workers", "african_christians", "african_islamic", "asian_city", "asian_rural", "east_european", "middle_eastern", "idap", "scientists"], ["Altis", "Workers", "African Christians", "African Islamic", "Asian City", "Asian Rural", "East European", "Middle Eastern", "IDAP", "Scientists"], 0]]
], {
    params ["_dialogValues", "_pos"];
    _dialogValues params ["_size", "_amount", "_preset"];

    [QGVAR(createCivilianCenter), [_pos, _size, _amount, _preset]] call CBA_fnc_serverEvent;
}, {}, _pos] call zen_dialog_fnc_create;
