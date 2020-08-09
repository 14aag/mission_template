#include "script_component.hpp"

{
    _x params ["_name", "_file"];
    [_name, [_file, "loadouts"] call EFUNC(inventory,loadInventoryFile)] call ace_arsenal_fnc_addDefaultLoadout;
} forEach [
    ["00 Base Loadout", "00_base"],
    ["01 Rifleman Loadout", "01_rifleman"],
    ["01.1 Grenadier Loadout", "01.1_Grenadier"],
    ["02 LAT Loadout", "02_lat"],
    ["02.1 HAT Loadout", "02.1_HAT"],
    ["03 Light AR Loadout", "03_light_ar"],
    ["04 Medium AR Loadout", "04_medium_ar"],
    ["05 Heavy AR Loadout", "05_heavy_ar"],
    ["06 DMR Loadout", "06_dmr"],
    ["07 Sniper Loadout", "07_sniper"],
    ["08 Medic Loadout", "08_medic"],
    ["09 Engineer Loadout", "09_engineer"],
    ["10 FTL/TL Loadout", "10_FTL_TL"]
    ["11 XO/CO Loadout", "11_XO_CO"]
];
