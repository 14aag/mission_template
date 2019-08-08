params ["_unit"];

private _loadout = getUnitLoadout _unit;
private _uniform = _loadout select 3;
private _vest = _loadout select 4;
private _backpack = _loadout select 5;
private _items = _loadout select 9;

_uniform set [1, [_uniform select 1] call efn_persistence_fnc_deInstancedRadios];
_vest set [1, [_vest select 1] call efn_persistence_fnc_deInstancedRadios];
_backpack set [1, [_backpack select 1] call efn_persistence_fnc_deInstancedRadios];
_items = [_items] call efn_persistence_fnc_deInstancedRadios;

[_loadout select 0, _loadout select 1, _loadout select 2, _uniform, _vest, _backpack, _loadout select 6, _loadout select 7, _loadout select 8, _items]

