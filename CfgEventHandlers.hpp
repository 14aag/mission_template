class Extended_Init_EventHandlers {
    class CAManBase {
        efn_man_init = "(_this select 0) disableAI 'RADIOPROTOCOL'";
    };
};

class Extended_PreStart_EventHandlers {
    class efn_mission {
        init = "call compile preprocessFileLineNumbers 'XEH_preStart.sqf'";
    };
    class efn_mission_commands {
        init = "call compile preprocessFileLineNumbers 'efn\commands\XEH_preStart.sqf'";
    };
    class efn_mission_fps {
        init = "call compile preprocessFileLineNumbers 'efn\fps\XEH_preStart.sqf'";
    };
    class efn_mission_intel {
        init = "call compile preprocessFileLineNumbers 'efn\intel\XEH_preStart.sqf'";
    };
    class efn_mission_inventory {
        init = "call compile preprocessFileLineNumbers 'efn\inventory\XEH_preStart.sqf'";
    };
    class efn_mission_persistence {
        init = "call compile preprocessFileLineNumbers 'efn\persistence\XEH_preStart.sqf'";
    };
    class efn_mission_respawn {
        init = "call compile preprocessFileLineNumbers 'efn\respawn\XEH_preStart.sqf'";
    };
    class efn_mission_workarounds {
        init = "call compile preprocessFileLineNumbers 'efn\workarounds\XEH_preStart.sqf'";
    };
    class efn_mission_volatile_area {
        init = "call compile preprocessFileLineNumbers 'efn\volatile_area\XEH_preStart.sqf'";
    };
};

class Extended_PreInit_EventHandlers {
    class efn_mission {
        init = "call compile preprocessFileLineNumbers 'XEH_preInit.sqf'";
    };
    class efn_mission_commands {
        init = "call compile preprocessFileLineNumbers 'efn\commands\XEH_preInit.sqf'";
    };
    class efn_mission_fps {
        init = "call compile preprocessFileLineNumbers 'efn\fps\XEH_preInit.sqf'";
    };
    class efn_mission_intel {
        init = "call compile preprocessFileLineNumbers 'efn\intel\XEH_preInit.sqf'";
    };
    class efn_mission_inventory {
        init = "call compile preprocessFileLineNumbers 'efn\inventory\XEH_preInit.sqf'";
    };
    class efn_mission_persistence {
        init = "call compile preprocessFileLineNumbers 'efn\persistence\XEH_preInit.sqf'";
    };
    class efn_mission_respawn {
        init = "call compile preprocessFileLineNumbers 'efn\respawn\XEH_preInit.sqf'";
    };
    class efn_mission_workarounds {
        init = "call compile preprocessFileLineNumbers 'efn\workarounds\XEH_preInit.sqf'";
    };
    class efn_mission_volatile_area {
        init = "call compile preprocessFileLineNumbers 'efn\volatile_area\XEH_preInit.sqf'";
    };
};

class Extended_PostInit_EventHandlers {
    class efn_mission {
        init = "call compile preprocessFileLineNumbers 'XEH_postInit.sqf'";
    };
    class efn_mission_commands {
        init = "call compile preprocessFileLineNumbers 'efn\commands\XEH_postInit.sqf'";
    };
    class efn_mission_fps {
        init = "call compile preprocessFileLineNumbers 'efn\fps\XEH_postInit.sqf'";
    };
    class efn_mission_intel {
        init = "call compile preprocessFileLineNumbers 'efn\intel\XEH_postInit.sqf'";
    };
    class efn_mission_inventory {
        init = "call compile preprocessFileLineNumbers 'efn\inventory\XEH_postInit.sqf'";
    };
    class efn_mission_persistence {
        init = "call compile preprocessFileLineNumbers 'efn\persistence\XEH_postInit.sqf'";
    };
    class efn_mission_respawn {
        init = "call compile preprocessFileLineNumbers 'efn\respawn\XEH_postInit.sqf'";
    };
    class efn_mission_workarounds {
        init = "call compile preprocessFileLineNumbers 'efn\workarounds\XEH_postInit.sqf'";
    };
    class efn_mission_volatile_area {
        init = "call compile preprocessFileLineNumbers 'efn\volatile_area\XEH_postInit.sqf'";
    };
};