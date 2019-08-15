if (isServer) exitWith {
    ["efn_persistence_player_ready", efn_persistence_fnc_handlePlayerReadyEvent] call CBA_fnc_addEventHandler;
};
if !(hasInterface) exitWith {};

["efn_persistence_player_state", {
    _this call efn_persistence_fnc_restoreUnitState;
    [_thisType, _thisId] call CBA_fnc_removeEventHandler
}] call CBA_fnc_addEventHandlerArgs;

nil