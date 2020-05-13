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

[QGVAR(player_state), {
    _this call FUNC(restoreUnitState);
    [_thisType, _thisId] call CBA_fnc_removeEventHandler
}] call CBA_fnc_addEventHandlerArgs;

["14 AAG Persistence", "Save current state", {[QGVAR(force_save)] call CBA_fnc_serverEvent;}] call zen_custom_modules_fnc_register;

nil