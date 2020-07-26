#include "script_component.hpp"
#include "XEH_PREP.hpp"

if (!hasInterface) exitWith {};

["14 AAG", "Allow Weapons", FUNC(moduleAllowWeapons)] call zen_custom_modules_fnc_register;
["ZEN_displayCuratorLoad", {[1] call FUNC(setZeusMarkerVisibility)}] call CBA_fnc_addEventHandler;
["ZEN_displayCuratorUnload", {[0] call FUNC(setZeusMarkerVisibility)}] call CBA_fnc_addEventHandler;

private _vivAction = [QGVAR(ViV), "Vehicle in Vehicle"] call zen_context_menu_fnc_createAction;
private _unloadAction = [QGVAR(UnloadVehicle), "Unload", "",
                         {_objects call FUNC(unloadVehicles)},
                         {_objects call FUNC(canUnloadVehicles)}] call zen_context_menu_fnc_createAction;
[_vivAction, [], 0] call zen_context_menu_fnc_addAction;
[_unloadAction, [QGVAR(ViV)], 0] call zen_context_menu_fnc_addAction;
