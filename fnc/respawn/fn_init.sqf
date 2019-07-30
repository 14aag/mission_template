if (!hasInterface) exitWith {};

// Determine marker and tent names
if (side player == east) then {
    sideTentType = "Misc_Backpackheap";
};
if (side player == west) then {
    sideTentType = "Misc_Backpackheap";
};
if (side player == independent) then {
    sideTentType = "Land_WW2_Zeltbahn";
};

[player, "killed", {
    [player, false] call efn_respawn_fnc_setAction;
}] call CBA_fnc_addBISEventHandler;

["leader", {
    [player] call efn_respawn_fnc_updateLeaderName;
}, true] call CBA_fnc_addPlayerEventHandler;

["efn_force_leader_name_update", { [player] call efn_respawn_fnc_updateLeaderName; }] call CBA_fnc_addEventHandler;

nil
