#include "script_component.hpp"
#include "XEH_PREP.hpp"

if (isServer) then {
    [QGVARMAIN(player_ready), FUNC(handlePlayerReadyEvent)] call CBA_fnc_addEventHandler;
};
if !(hasInterface) exitWith {};

[QGVAR(player_state), {
    _this call FUNC(restoreUnitState);
    [_thisType, _thisId] call CBA_fnc_removeEventHandler
}] call CBA_fnc_addEventHandlerArgs;

nil