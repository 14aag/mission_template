#include "script_component.hpp"
#include "XEH_PREP.hpp"

if (isServer) then {
    [QGVARMAIN(player_ready), FUNC(handlePlayerReadyEvent)] call CBA_fnc_addEventHandler;
    [QGVAR(force_save), FUNC(forceSave)] call CBA_fnc_addEventHandler;
};

[QGVAR(setVehicleVarNameEvent), {
    params ["_vehicle", "_name"];
    _vehicle setVehicleVarName _name;
    missionNamespace setVariable [_name, _vehicle];
}] call CBA_fnc_addEventHandler;

if !(hasInterface) exitWith {};

[QGVAR(player_state), FUNC(restoreUnitState)] call CBA_fnc_addEventHandlerArgs;

["14 AAG Persistence", "Save current state", {[QGVAR(force_save)] call CBA_fnc_serverEvent;}] call zen_custom_modules_fnc_register;
["14 AAG Persistence", "Load fetched state", FUNC(moduleLoadState)] call zen_custom_modules_fnc_register;
["14 AAG Persistence", "Fetch saved state", FUNC(moduleSaveLocally)] call zen_custom_modules_fnc_register;

GVAR(excludeZeusPlaced) = getMissionConfigValue [QGVAR(excludeZeus), false] in [true, 1];
["ModuleCurator_F", "init", {
    params ["_logic"];

    _logic addEventHandler ["CuratorObjectPlaced", {
        params ["", "_entity"];
        _entity setVariable [QGVAR(excluded), GVAR(excludeZeusPlaced), 2];
    }];
}] call CBA_fnc_addClassEventHandler;

nil
