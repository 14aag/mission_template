#include "script_component.hpp"

params ["_msg", "_type", "_receiver"];

private _callsign = switch (toLower _type) do {
    case "zeus": {"to Zeus"};
    case "whisper": {format ["Whisper to %1", _receiver]};
    default {"Chat"};
};

[_msg, _callsign] call FUNC(showMessage);

[QGVAR(chatMessage), [profileName, _msg, _type, _receiver]] call CBA_fnc_globalEvent;
