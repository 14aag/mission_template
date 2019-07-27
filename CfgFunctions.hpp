class CfgFunctions {
    class efn {
        class common {
            class init_splosionWorkaround {
                file = "fnc\fn_init_splosionWorkaround.sqf";
                preInit = 1;
            };
            class updateFps {
                file = "fnc\fn_updateFps.sqf";
            };
            class toggleShowFps {
                file = "fnc\fn_toggleShowFps.sqf";
            };
            class drawFps {
                file = "fnc\fn_drawFps.sqf";
            };
        };
        class loadoutBox {
            class loadoutBox_init {
                file = "fnc\loadout\fn_loadoutBox_init.sqf";
            };
        };
        class intel {
            class initIntel {
                file = "fnc\intel\fn_initIntel.sqf";
            };
            class initIntelHold {
                file = "fnc\intel\fn_initIntelHold.sqf";
            };
            class addIntel {
                file = "fnc\intel\fn_addIntel.sqf";
            };
            class addIntelLocal {
                file = "fnc\intel\fn_addIntelLocal.sqf";
            };
        };
    };

    class efn_respawn {
        class respawn {
            class init {
                file = "fnc\respawn\fn_init.sqf";
                postInit = 1;
            };
            class placeTent {
                file = "fnc\respawn\fn_placeTent.sqf";
            };
            class findEmptyPosition {
                file = "fnc\respawn\fn_findEmptyPosition.sqf";
            };
            class setAction {
                file = "fnc\respawn\fn_setAction.sqf";
            };
            class updateLeaderName {
                file = "fnc\respawn\fn_updateLeaderName.sqf";
            };
        };
    };

    #include "KPCF\KPCF_functions.hpp"
};
