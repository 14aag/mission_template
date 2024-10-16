#include "script_component.hpp"
#include "XEH_PREP.hpp"

if !(hasInterface) exitWith {};

[QGVAR(chatMessage), {
    params ["_sender", "_msg", "_type", "_receiver"];

    private _args = switch (toLower _type) do {
        case "zeus": {
            [{!isNull (getAssignedCuratorLogic player)}, format ["(Zeus) %1", _sender]];
        };
        case "whisper": {
            [{profileName isEqualTo _receiver}, format ["Whisper from %1", _sender]];
        };
        default {
            [{true}, format ["Notice (%1)", _sender]];
        };
    };
    _args params ["_condition", "_text"];

    if ([] call _condition) then {
        [_msg, _text] call FUNC(showMessage);
    };
}] call CBA_fnc_addEventHandler;