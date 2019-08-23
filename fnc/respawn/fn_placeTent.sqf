#include "script_component.hpp"

private _playerCount = { _x != player && _x distance2D player < 5 } count allPlayers;
if (_playerCount < 1) exitWith { hint "Not enough people or too far"; };

if (speed player > 0) exitWith {
    hint "You are moving too fast";
};

private _tentPos = [player] call FUNC(findEmptyPosition);
if !(_tentPos isEqualTo []) then {
    player playActionNow "PutDown";
    [QGVAR(place_tent), [player, _tentPos]] call CBA_fnc_serverEvent;
} else {
    hint "Not enough space";
};

nil
