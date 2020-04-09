#include "script_component.hpp"
#include "XEH_PREP.hpp"

if (!hasInterface) exitWith {};

["14 AAG", "Allow Weapons", FUNC(moduleAllowWeapons)] call zen_custom_modules_fnc_register;
["ZEN_displayCuratorLoad", {[1] call FUNC(setZeusMarkerVisibility)}] call CBA_fnc_addEventHandler;
["ZEN_displayCuratorUnload", {[0] call FUNC(setZeusMarkerVisibility)}] call CBA_fnc_addEventHandler;
