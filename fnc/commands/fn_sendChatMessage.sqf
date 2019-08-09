params ["_msg", "_type", "_receiver"];

private _callsign = switch (toLower _type) do {
    case "zeus": {"to Zeus:"};
    case "whisper": {format ["Whisper to %1:", _receiver]};
    default {"Chat:"};
};

efn_chatcommands_chatChannel radioChannelAdd [ACE_player];
efn_chatcommands_chatChannel radioChannelSetCallSign _callsign;
player customChat [efn_chatcommands_chatChannel, _msg];
efn_chatcommands_chatChannel radioChannelRemove [ACE_player];

["efn_chatcommands_chatMessage", [profileName, _msg, _type, _receiver]] call CBA_fnc_globalEvent;
