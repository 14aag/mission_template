class CfgFunctions {
    class efn {
        class intel {
            file = "fnc\intel";
            class initIntel {};
            class initIntelHold {};
            class addIntel {};
            class addIntelLocal {};
        };
    };

    class efn_inventory {
        class inventory {
            file = "fnc\inventory";
            class initArsenalWhitelist {};
            class initLoadoutBox {};
            class loadWhitelist {};
        };
    };

    class efn_workarounds {
        class workarounds {
            file = "fnc\workarounds";
            class splosionWorkaround {
                preInit = 1;
            };
            class zeusWorkaround {
                preInit = 1;
            };
            class reassignZeus {};
        };
    };

    class efn_fps {
        class fps {
            file = "fnc\fps";
            class init {
                postInit = 1;
            };
            class updateFps {};
            class toggleShowFps {};
            class drawFps {};
        };
    };

    class efn_respawn {
        class respawn {
            file = "fnc\respawn";
            class init {
                postInit = 1;
            };
            class placeTent {};
            class findEmptyPosition {};
            class setAction {};
            class updateLeaderName {};
            class getTent {};
            class handlePlaceTentEvent {};
            class handlePlayerRespawnEvent {};
            class movePlayerToSpawn {};
            class setSpectator {};
            class notify {};
        };
    };

    class efn_persistence {
        class persistence {
            file = "fnc\persistence";
            class preInit {
                preInit = 1;
            };
            class postInit {
                postInit = 1;
            };
            class getSanitizedUnitLoadout {};
            class deInstancedRadios {};
            class save {};
            class resetCurrent {};
            class handlePlayerReadyEvent {};
            class buildUnitState {};
            class restoreUnitState {};
        };
    };

    class efn_commands {
        class commands {
            file = "fnc\commands";
            class preInit {
                preInit = 1;
            };
            class postInit {
                postInit = 1;
            };
            class sendChatMessage {};
            class getPlayer {};
        };
    };

    #include "KPCF\KPCF_functions.hpp"
};
