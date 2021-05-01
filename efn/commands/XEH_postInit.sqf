#include "script_component.hpp"

if (isServer) then {
    GVAR(chatChannel) = radioChannelCreate [[0.9,0.1,0.1,1], "Chat", "Chat", [], true];
    publicVariable QGVAR(chatChannel);
};

if !(hasInterface) exitWith {};

["zeus", {
    params ["_msg"];
    _msg = [_msg] call CBA_fnc_trim;
    if (_msg isEqualTo "") exitWith {};
    [_msg, "zeus"] call FUNC(sendChatMessage);
}, "all"] call CBA_fnc_registerChatCommand;

["whisper", {
    params ["_str"];
    private _split = (_str splitString " ");
    private _to = _split param [0, ""];
    _split deleteAt 0;
    private _msg = _split joinString " ";
    if (_to isEqualTo "" || _msg isEqualTo "") exitWith { systemChat "Invalid arguments" };

    private _receiver = [_to] call FUNC(getPlayer);
    if (isNull _receiver) exitWith { systemChat "Could not find receiver" };
    [_msg, "whisper", name _receiver] call FUNC(sendChatMessage);
}, "all"] call CBA_fnc_registerChatCommand;

["groupname", {
    params ["_name"];

    if !((leader ace_player) isEqualTo ace_player) exitWith {
        systemChat "Only the group leader can set the name!";
    };

    private _index = allGroups findIf {(groupId _x) isEqualTo _name};
    if (_index > -1) exitWith {
        systemChat "That group name already exists!";
    };

    (group ace_player) setGroupIdGlobal [_name];
}, "all"] call CBA_fnc_registerChatCommand;

["help", {
    [{
        systemChat "--- Available chat commands ---";
        systemChat "zeus - Send a message to zeus (#zeus smite me)";
        systemChat "whisper - Send a whisper to a player (#whisper clips what's up)";
        systemChat "groupname - Change name of group on cTab (group leaders only)";
        systemChat "--- End ---";
    }] call CBA_fnc_execNextFrame;
}, "all"] call CBA_fnc_registerChatCommand;

["CBA_loadingScreenDone", {
    [{
        systemChat "Type #help to see available commands";
    }, [], 5] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;
