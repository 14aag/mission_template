#include "script_component.hpp"
#include "XEH_PREP.hpp"

if (isServer) then {
    [QGVAR(kh55Strike), FUNC(kh55Strike)] call CBA_fnc_addEventHandler;
};

if (!hasInterface) exitWith {};

["14 AAG", "Allow Weapons", FUNC(moduleAllowWeapons)] call zen_custom_modules_fnc_register;
["14 AAG", "Configure Personal Moon", FUNC(modulePersonalMoon)] call zen_custom_modules_fnc_register;
if (isClass (configFile >> "CfgAmmo" >> "rhs_ammo_kh55sh")) then {
    ["14 AAG Fire Support", "Kh55 HE Strike", FUNC(moduleKh55Strike)] call zen_custom_modules_fnc_register;
};

["zen_curatorDisplayLoaded", {[1] call FUNC(setZeusMarkerVisibility)}] call CBA_fnc_addEventHandler;
["zen_curatorDisplayUnloaded", {[0] call FUNC(setZeusMarkerVisibility)}] call CBA_fnc_addEventHandler;

private _vivAction = [QGVAR(ViV), "Vehicle in Vehicle"] call zen_context_menu_fnc_createAction;
private _unloadAction = [QGVAR(UnloadVehicle), "Unload", "",
                         {_objects call FUNC(unloadVehicles)},
                         {_objects call FUNC(canUnloadVehicles)}] call zen_context_menu_fnc_createAction;
[_vivAction, [], 0] call zen_context_menu_fnc_addAction;
[_unloadAction, [QGVAR(ViV)], 0] call zen_context_menu_fnc_addAction;
