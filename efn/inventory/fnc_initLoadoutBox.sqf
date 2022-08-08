#include "script_component.hpp"
params ["_box", "_name", "_loadout", ["_ignore", [], [[]]]];

if (_loadout isEqualType "") then {
    private _file = _loadout;
    _loadout = [_file, "loadouts"] call FUNC(loadInventoryFile);
    if (_loadout isEqualTo objNull) exitWith {
        ["Loadout file (%1) not found or failed to load", _file] call BIS_fnc_error;
    };
};

private _load = {
    params ["_target", "_caller", "_actionId", "_arguments"];

    _caller setUnitLoadout (_arguments select 0);
};

_ignore = _ignore arrayIntersect ["uniform", "vest", "backpack", "helmet", "facewear", "binocular", "map", "gps", "radio", "compass", "watch", "nvg"];
if (count _ignore > 0) then {
    _load = {
        params ["_target", "_caller", "_actionId", "_arguments"];
        _arguments params ["_loadout", "_ignore"];

        private _current = getUnitLoadout _caller;
        _loadout = +_loadout;

        private _uniformLoad = 0;
        if (_ignore find "uniform" != -1 && {(maxLoad uniformContainer _caller) > 0}) then {
            _uniformLoad = getContainerMaxLoad (_loadout select 3 select 0);
            _loadout select 3 set [0, _current select 3 select 0];
        };

        private _vestLoad = 0;
        if (_ignore find "vest" != -1 && {(maxLoad vestContainer _caller) > 0}) then {
            _vestLoad = getContainerMaxLoad (_loadout select 4 select 0);
            _loadout select 4 set [0, _current select 4 select 0];
        };

        private _backpackLoad = 0;
        if (_ignore find "backpack" != -1 && {!isNull backpackContainer _caller}) then {
            if ((maxLoad backpackContainer _caller) == 0) then {
                _caller addBackpack backpack _caller;
                removeBackpack _caller;
            } else {
                _backpackLoad = getContainerMaxLoad (_loadout select 5 select 0);
                _loadout select 5 set [0, _current select 5 select 0];
            };
        };

        if (_ignore find "helmet" != -1) then {
            _loadout set [6, _current select 6];
        };

        if (_ignore find "facewear" != -1) then {
            _loadout set [7, _current select 7];
        };

        if (_ignore find "binocular" != -1) then {
            _loadout set [8, _current select 8];
        };

        if (_ignore find "map" != -1) then {
            _loadout select 9 set [0, _current select 9 select 0];
        };

        if (_ignore find "gps" != -1) then {
            _loadout select 9 set [1, _current select 9 select 1];
        };

        if (_ignore find "radio" != -1) then {
            _loadout select 9 set [2, _current select 9 select 2];
        };

        if (_ignore find "compass" != -1) then {
            _loadout select 9 set [3, _current select 9 select 3];
        };

        if (_ignore find "watch" != -1) then {
            _loadout select 9 set [4, _current select 9 select 4];
        };

        if (_ignore find "nvg" != -1) then {
            _loadout select 9 set [5, _current select 9 select 5];
        };

        _caller setUnitLoadout _loadout;
        if (_uniformLoad > 0 && {!isNull uniformContainer _caller}) then {
            (uniformContainer _caller) setMaxLoad _uniformLoad;
        };
        if (_vestLoad > 0 && {!isNull vestContainer _caller}) then {
            (vestContainer _caller) setMaxLoad _vestLoad;
        };
        if (_backpackLoad > 0 && {!isNull backpackContainer _caller}) then {
            (backpackContainer _caller) setMaxLoad _backpackLoad;
        };
    };
};

_box addAction [format ["Take %1 loadout", _name], _load, [_loadout, _ignore], 1.5, false, true, "", "true", 5];
