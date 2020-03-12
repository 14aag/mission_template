#include "script_component.hpp"

["CBA_loadingScreenDone", {
    [QGVARMAIN(player_ready), [player]] call CBA_fnc_serverEvent;
}] call CBA_fnc_addEventHandler;
