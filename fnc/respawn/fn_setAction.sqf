params ["_unit", "_isLeader"];

if (_isLeader && isNil "efn_respawn_actionId") then {
    efn_respawn_actionId = _unit addAction ["Place respawn", efn_respawn_fnc_placeTent, nil, 0, false];
};

if (!_isLeader && !(isNil "efn_respawn_actionId")) then {
    _unit removeAction efn_respawn_actionId;
    efn_respawn_actionId = nil;
};

nil
