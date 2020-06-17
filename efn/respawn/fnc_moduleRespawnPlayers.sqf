#include "script_component.hpp"

private _players = allPlayers select { _x getVariable [QGVAR(dead), false] };
if (_players isEqualTo []) exitWith {
    ["No dead players found"] call zen_common_fnc_showMessage;
};

[
    "Respawn players",
    [["OWNERS:NOTITLE", "", [[], [], _players]]],
    {
        params ["_values", "_args"];
        _values params ["_owners"];

        private _players = [_owners select (_owners select 3)] call zen_common_fnc_getPlayers;
        [QGVAR(respawn), [], _players] call CBA_fnc_targetEvent;
    }
] call zen_dialog_fnc_create;
