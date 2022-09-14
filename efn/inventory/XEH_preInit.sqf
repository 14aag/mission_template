#include "script_component.hpp"
#include "XEH_PREP.hpp"

GVAR(forbiddenItems) = [];
GVAR(lootingForbidden) = false;

GVAR(hasAIME) = isClass (configFile >> "CfgPatches" >> "UPSL_aime_inventory");
["14 AAG", "Forbid Looting", FUNC(moduleForbidLooting)] call zen_custom_modules_fnc_register;
