if !(hasInterface) exitWith {};

["efn_chatcommands_chatMessage", {
    params ["_sender", "_msg", "_type", "_receiver"];

    private _args = switch (toLower _type) do {
        case "zeus": {
            [{!isNull (getAssignedCuratorLogic player)}, format ["(Zeus) %1:", _sender]];
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
        efn_chatcommands_chatChannel radioChannelAdd [ACE_player];
        efn_chatcommands_chatChannel radioChannelSetCallSign _text;
        ACE_player customChat [efn_chatcommands_chatChannel, _msg];
        efn_chatcommands_chatChannel radioChannelRemove [ACE_player];
    };
}] call CBA_fnc_addEventHandler;