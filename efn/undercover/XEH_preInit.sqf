#include "script_component.hpp"
#include "XEH_PREP.hpp"

[QGVAR(setUndercover), FUNC(setUndercoverLocal)] call CBA_fnc_addEventHandler;
["ace_explosives_place", FUNC(explosivePlacedHandler)] call CBA_fnc_addEventHandler;

["14 AAG", "Toggle undercover", FUNC(moduleToggleUndercover)] call zen_custom_modules_fnc_register;
