#include "script_component.hpp"
params ["_msg", "_callsign"];

systemChat format ["%1: %2", _callsign, _msg];
/*
efn_commands_chatChannel radioChannelAdd [ace_player];
efn_commands_chatChannel radioChannelSetCallSign "zeus";
[{
  ace_player customChat [efn_commands_chatChannel, "asdfa"];
  efn_commands_chatChannel radioChannelRemove [ace_player];
}, [], 0.1] call CBA_fnc_waitAndExecute;
*/