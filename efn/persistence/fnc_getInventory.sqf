#include "script_component.hpp"
params ["_container"];

private _items = [itemCargo _container] call FUNC(deInstancedRadios);
private _unique = _items arrayIntersect _items;
private _itemCargo = _unique apply {
    private _class = _x;
    [_class, {_class == _x} count _items]
};
private _weaponsCargo = weaponsItemsCargo _container;
private _magazineCargo = magazinesAmmoCargo _container;
private _containers = (everyContainer _container) apply {
    [typeOf (_x select 1), [_x select 1] call FUNC(getInventory)]
};

[_itemCargo, _weaponsCargo, _magazineCargo, _containers]
