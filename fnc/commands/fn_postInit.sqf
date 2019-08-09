if (isServer) then {
    efn_chatcommands_chatChannel = radioChannelCreate [[0.9,0.1,0.1,1], "Chat", "Chat", [], true];
    publicVariable "efn_chatcommands_chatChannel";
};

if !(hasInterface) exitWith {};

["zeus", {
    params ["_msg"];
    _msg = [_msg] call CBA_fnc_trim;
    if (_msg isEqualTo "") exitWith {};
    [_msg, "zeus"] call efn_chatcommands_fnc_sendChatMessage;
}, "all"] call CBA_fnc_registerChatCommand;

["whisper", {
    params ["_str"];
    private _split = (_str splitString " ");
    private _to = _split param [0, ""];
    _split deleteAt 0;
    private _msg = _split joinString " ";
    if (_to isEqualTo "" || _msg isEqualTo "") exitWith { systemChat "Invalid arguments" };

    private _receiver = [_to] call efn_chatcommands_fnc_getPlayer;
    if (isNull _receiver) exitWith { systemChat "Could not find receiver" };
    [_msg, "whisper", name _receiver] call efn_chatcommands_fnc_sendChatMessage;
}, "all"] call CBA_fnc_registerChatCommand;

