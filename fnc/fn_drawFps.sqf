{
    private _distance = (AGLToASL (positionCameraToWorld [0,0,0])) distance (eyePos _x);
    if (_distance < 1200) then {
        private _fps = _x getVariable ["efn_player_fps", 50];
        private _pos = _x modelToWorldVisual ((_x selectionPosition "pilot") vectorAdd [0, 0, _distance * 0.026 + 0.25]);
        private _color = if (_fps < 20) then { [1,0,0,0.7] } else { [1,1,1,0.5] };
        drawIcon3D ["", _color, _pos, 1, 1, 0, format ["FPS: %1", str _fps], 2, 0.04, "RobotoCondensed", "center"];
    };
} forEach allPlayers;
