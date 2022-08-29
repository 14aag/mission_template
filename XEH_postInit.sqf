#include "script_component.hpp"

{
    _x params ["_name", "_file"];
    [_name, [_file, "loadouts"] call EFUNC(inventory,loadInventoryFile)] call ace_arsenal_fnc_addDefaultLoadout;
} forEach [
    ["00 Base Loadout", "00_base"]
];

[["ItemRadio", "ItemGPS"]] call efn_inventory_fnc_forbidItems;
