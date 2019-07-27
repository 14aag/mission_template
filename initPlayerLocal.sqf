[] call efn_fnc_updateFps;

["14aag_zeus_fps", "show_fps", "Toggle FPS overlay", "", {
    [] call efn_fnc_toggleShowFps;
}] call CBA_fnc_addKeybind;

[player, "killed", {
    player setVariable ["saved_loadout", getUnitLoadout player];
}] call CBA_fnc_addBISEventHandler;

[player, "respawn", {
    private _loadout = player getVariable ["saved_loadout", []];
    if !(_loadout isEqualTo []) then {
        player setUnitLoadout _loadout;
    }
}] call CBA_fnc_addBISEventHandler;

["test", { systemChat "testing"; }, "all"] call CBA_fnc_registerChatCommand;
