#include "script_component.hpp"

private _playerCount = { _x != player && _x distance2D player < 5 } count allPlayers;
if (_playerCount < 1) exitWith { ["Not enough people or too far"] call FUNC(notify); };

if (speed player > 0) exitWith {
    ["You are moving too fast"] call FUNC(notify);
};

private _tentPos = [player] call FUNC(findEmptyPosition);
if !(_tentPos isEqualTo []) then {
    [QGVAR(place_tent), [player, _tentPos]] call CBA_fnc_serverEvent;
} else {
    ["Not enough space"] call FUNC(notify);
};

nil
