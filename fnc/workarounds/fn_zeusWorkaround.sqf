if (isServer) then {
    ["ace_zeus_zeusUnitAssigned", {
        params ["_logic", "_player"];
        _player setVariable ["efn_workarounds_zeus_logic", _logic];
    }] call CBA_fnc_addEventHandler;
    ["efn_player_ready", efn_workarounds_fnc_reassignZeus] call CBA_fnc_addEventHandler;
};

nil
