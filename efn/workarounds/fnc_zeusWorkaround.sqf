#include "script_component.hpp"

if (isServer) then {
    ["ace_zeus_zeusUnitAssigned", {
        params ["_logic", "_player"];
        _player setVariable [QGVAR(zeus_logic), _logic];
    }] call CBA_fnc_addEventHandler;
    [QGVARMAIN(player_ready), FUNC(reassignZeus)] call CBA_fnc_addEventHandler;
};

nil
