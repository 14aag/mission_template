#include "script_component.hpp"
#include "XEH_PREP.hpp"

GVAR(tent) = objNull;
["14 AAG", "Assign Respawn", FUNC(moduleAssignRespawn)] call zen_custom_modules_fnc_register;
["14 AAG", "Respawn players", FUNC(moduleRespawnPlayers)] call zen_custom_modules_fnc_register;

["MouseButtonDown", {
    params ["", "_button"];
    if (_button == 1 && !isNull GVAR(tent)) then {
        deleteVehicle GVAR(tent);
    };
}] call CBA_fnc_addDisplayHandler;
