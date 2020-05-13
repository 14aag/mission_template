#include "script_component.hpp"
params ["_target", "_inventory"];
_inventory params ["_itemCargo", "_weaponCargo", "_magazineCargo", "_containers"];

clearItemCargoGlobal _target;
clearWeaponCargoGlobal _target;
clearMagazineCargoGlobal _target;
clearBackpackCargoGlobal _target;
{
    _target addItemCargoGlobal _x;
} forEach _itemCargo;

{
    _target addWeaponWithAttachmentsCargoGlobal [_x, 1];
} forEach _weaponCargo;

{
    _target addMagazineAmmoCargo [_x select 0, 1, _x select 1];
} forEach _magazineCargo;

private _nonBackpacks = everyContainer _target;
{
    _x params ["_name", "_inventory"];
    private _i = _nonBackpacks findIf {
        (typeOf (_x select 1)) == _name
    };
    private _c = if (_i >= 0) then {
        (_nonBackpacks deleteAt _i) select 1;
    } else {
        _target addBackpackCargoGlobal [_name, 1];
        private _backpacks = everyBackpack _target;
        if (count _backpacks > 0) then {
            _backpacks select (count _backpacks - 1);
        } else {
            objNull;
        };
    };
    if (!isNull _c) then {
        [_c, _inventory] call FUNC(setContainerInventory);
    };
} forEach _containers;
