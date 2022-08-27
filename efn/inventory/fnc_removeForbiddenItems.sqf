#include "script_component.hpp"
private _loadout = getUnitLoadout player;
private _foundForbidden = (flatten _loadout) arrayIntersect GVAR(forbiddenItems);

if (_foundForbidden isNotEqualTo []) then {
    if (!isNull (findDisplay 602)) exitWith {
        systemChat format ["forbidden items will be removed %1", _foundForbidden];
    };

    systemChat format ["forbidden items removed %1", _foundForbidden];
    _loadout params ["_primary", "_launcher", "_secondary", "_uniform", "_vest", "_backpack", "_helmet", "_facewear", "_binocular", "_items"];

    if (GVAR(forbiddenItems) find _primary#0 != -1) then {
        _primary = [];
    };
    if (GVAR(forbiddenItems) find _launcher#0 != -1) then {
        _launcher = [];
    };
    if (GVAR(forbiddenItems) find _secondary#0 != -1) then {
        _secondary = [];
    };

    private _fnc_filterWeapon = {
        params ["_weapon"];

        if (_weapon isNotEqualTo []) then {
            _weapon set [0, [_weapon#0, ""] select (GVAR(forbiddenItems) find _weapon#0 != -1)];
            _weapon set [1, [_weapon#1, ""] select (GVAR(forbiddenItems) find _weapon#1 != -1)];
            _weapon set [2, [_weapon#2, ""] select (GVAR(forbiddenItems) find _weapon#2 != -1)];
            _weapon set [3, [_weapon#3, ""] select (GVAR(forbiddenItems) find _weapon#3 != -1)];
            if (_weapon#4 isNotEqualTo []) then {
                _weapon set [4, [_weapon#4, []] select (GVAR(forbiddenItems) find _weapon#4#0 != -1)];
            };
            if (_weapon#5 isNotEqualTo []) then {
                _weapon set [5, [_weapon#5, []] select (GVAR(forbiddenItems) find _weapon#5#0 != -1)];
            };
            _weapon set [6, [_weapon#6, ""] select (GVAR(forbiddenItems) find _weapon#6 != -1)];
        };
    };

    {
        [_x] call _fnc_filterWeapon;
    } forEach [_primary, _launcher, _secondary];

    private _fnc_filterContainer = {
        params ["_container"];
        {
            if (_x#0 isEqualType []) then {
                private _weapon = _x#0;
                if (GVAR(forbiddenItems) find _weapon#0 != -1) then {
                    _x resize 0;
                } else {
                    [_weapon] call _fnc_filterWeapon;
                };
            } else {
                if (GVAR(forbiddenItems) find _x#0 != -1) then {
                    _x resize 0;
                };
            };
        } forEach (_container);
    };

    if (_uniform isNotEqualTo []) then {
        if (GVAR(forbiddenItems) find _uniform#0 != -1) then {
            _uniform = [];
        } else {
            [_uniform#1] call _fnc_filterContainer;
        };
    };
    if (_vest isNotEqualTo []) then {
        if (GVAR(forbiddenItems) find _vest#0 != -1) then {
            _vest = [];
        } else {
            [_vest#1] call _fnc_filterContainer;
        };
    };
    if (_backpack isNotEqualTo []) then {
        if (GVAR(forbiddenItems) find _backpack#0 != -1) then {
            _backpack = [];
        } else {
            [_backpack#1] call _fnc_filterContainer;
        };
    };

    if (GVAR(forbiddenItems) find _helmet != -1) then {
        _helmet = "";
    };
    if (GVAR(forbiddenItems) find _facewear != -1) then {
        _facewear = "";
    };
    if (_binocular isNotEqualTo []) then {
        if (GVAR(forbiddenItems) find _binocular#0 != -1) then {
            _binocular = [];
        };
        [_binocular] call _fnc_filterWeapon;
    };

    {
        if (GVAR(forbiddenItems) find _x != -1) then {
            _items set [_forEachIndex, ""];
        };
    } forEach _items;

    private _newLoadout = [_primary, _launcher, _secondary, _uniform, _vest, _backpack, _helmet, _facewear, _binocular, _items];
    player setUnitLoadout _newLoadout;
};
