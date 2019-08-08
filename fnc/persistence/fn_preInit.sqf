if !(hasInterface) exitWith {};

["efn_player_state", {
    _this params ["_loadout", "_pos"];
    if !(_loadout isEqualTo objNull) then {
        player setUnitLoadout _loadout;
    };

    if !(_pos isEqualTo objNull) then {
        player setDir (_pos select 0);
        player setPos (_pos select 1);
    };

    [_thisType, _thisId] call CBA_fnc_removeEventHandler
}] call CBA_fnc_addEventHandlerArgs;

nil