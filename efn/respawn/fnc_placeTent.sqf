#include "script_component.hpp"

private _playerCount = { _x != player && _x distance2D player < GVAR(maxPlayerDistance) } count allPlayers;
if (_playerCount < GVAR(minPlayersNear)) exitWith { ["Not enough people nearby"] call FUNC(notify); };

private _pos = player getRelPos [1.8, 0];

_pos set [2, ((getPosATL player) select 2)];
GVAR(tent) = createSimpleObject [GVAR(tentType), _pos, true];
GVAR(tent) setPosATL _pos;
GVAR(tent) attachTo [player];

[{
    params ["_tent"];

    if !(
        alive player
        && {!(player call ace_common_fnc_isSwimming)}
        && {[player, objNull, ["isNotInside", "isNotOnLadder", "isNotSwimming", "isNotRefueling", "notOnMap"]] call ace_common_fnc_canInteractWith}
        && {!("unconscious" isEqualTo toLower animationState player)}
        && {!(player getVariable ["ACE_isUnconscious", false])}
        && {vehicle player == player}
    ) exitWith {
        true
    };

    if !(isNull _tent) then {
        private _pos = player getRelPos [1.8, 0];
        _pos set [2, ((getPosATL player) select 2)];
        _tent setPosATL _pos;

        private _collisionCheck = {
            params ["_tent"];
            private _pos = getPosASL _tent;
            private _intersect = lineIntersectsSurfaces [_pos vectorAdd [0, 0, 0.5], _pos vectorAdd [0, 0, 2], _tent, player, false, 1, "FIRE", "NONE"];

            if (!(_intersect isEqualTo [])) exitWith {
                false
            };

            _intersect = lineIntersectsSurfaces [_pos vectorAdd [0, 0, 0.5], _pos vectorAdd [0, 0, -0.5], _tent, player, false, 1, "FIRE", "NONE"];
            if (_intersect isEqualTo []) exitWith {
                false
            };

            if (surfaceIsWater _pos && {_pos select 2 < 0}) exitWith { false };

            private _ret = true;
            for "_angle" from 0 to 359 step 45 do {
                private _sidePos = _tent getRelPos [1.5, _angle];
                _sidePos set [2, _pos select 2];
                _intersect = lineIntersectsSurfaces [_pos vectorAdd [0, 0, 0.5], _sidePos vectorAdd [0, 0, 0.5], _tent, player, false, 1, "FIRE", "NONE"];

                if (!(_intersect isEqualTo [])) exitWith {
                    _ret = false;
                };

                _intersect = lineIntersectsSurfaces [_sidePos vectorAdd [0, 0, 0.5], _sidePos vectorAdd [0, 0, -0.5], _tent, player, false, 1, "FIRE", "NONE"];
                if (_intersect isEqualTo []) exitWith {
                    _ret = false
                };
            };

            _ret
        };

        if (_tent call _collisionCheck) then {
            ["Place bag", "Cancel"] call ace_interaction_fnc_showMouseHint;
            _tent hideObject false;
        } else {
            ["", "Cancel"] call ace_interaction_fnc_showMouseHint;
            _tent hideObject true;
        };
    };
    isNull _tent;
}, {
    call FUNC(endTentPlacementMode);
}, [GVAR(tent)]] call CBA_fnc_waitUntilAndExecute;

[player, "forceWalk", QUOTE(ADDON), true] call ace_common_fnc_statusEffect_set;
[player, "blockThrow", QUOTE(ADDON), true] call ace_common_fnc_statusEffect_set;

player setVariable [QGVAR(placeAction), [player, "DefaultAction", {!isNull GVAR(tent)}, {
    if (!isObjectHidden GVAR(tent)) then {
        private _playerCount = { _x != player && _x distance2D player < GVAR(maxPlayerDistance) } count allPlayers;
        if (_playerCount < GVAR(minPlayersNear)) exitWith { ["Not enough people nearby"] call FUNC(notify); };

        [QGVAR(place_tent), [player, getPosATL GVAR(tent)]] call CBA_fnc_serverEvent;
        deleteVehicle GVAR(tent);
    };
}] call ace_common_fnc_addActionEventHandler];
nil
