#include "script_component.hpp"

params ["_items"];

_deInstancedItems = _items apply {
    private _ret = _x;
    if (_x isEqualType []) then {
        _ret = [_x] call FUNC(deInstancedRadios);
    } else {
        if (_x isEqualType "" && {_x isKindOf ["ItemRadio", configFile >> "CfgWeapons"]}) then {
            _ret = [configFile >> "CfgWeapons" >> _x >> "tf_parent", "text", _x] call CBA_fnc_getConfigEntry;
        };
    };

    _ret
};

_deInstancedItems