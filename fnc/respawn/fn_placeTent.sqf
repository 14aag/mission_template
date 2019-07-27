private _playerCount = { _x != player && _x distance2D player < 5 } count allPlayers;
if (_playerCount < 1) exitWith { hint "Not enough people or too far"; };

if (speed player > 0) exitWith {
    hint "You are moving too fast";
};

private _tentPos = [player] call efn_respawn_fnc_findEmptyPosition;
if !(_tentPos isEqualTo []) then {
    player playActionNow "PutDown";
    if (isNil "tent") then {
        tent = sideTentType createVehicle _tentPos;
    } else {
        tent setPos _tentPos;
    };
    (format ["respawn_%1", vehicleVarName player]) setMarkerPos _tentPos;
} else {
    hint "Not enough space";
};

nil
