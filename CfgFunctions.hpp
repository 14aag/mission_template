class CfgFunctions {
    class efn {
        class common {
            file = "fnc";
            class init_splosionWorkaround {
                preInit = 1;
            };
            class updateFps {};
            class toggleShowFps {};
            class drawFps {};
        };
        class loadoutBox {
            class loadoutBox_init {
                file = "fnc\loadout\fn_loadoutBox_init.sqf";
            };
        };
        class intel {
            file = "fnc\intel";
            class initIntel {};
            class initIntelHold {};
            class addIntel {};
            class addIntelLocal {};
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
        };
    };

    class efn_chatcommands {
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
