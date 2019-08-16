private _isAdmin = serverCommandAvailable "#kick";
private _isZeus = !isNull (getAssignedCuratorLogic player);

systemChat format ["isAdmin %1 isZeus %2", _isAdmin, _isZeus];
if (_isAdmin || _isZeus) then {
    if (isNil "efn_fps_drawHandle") then {
        systemChat "turn on";
        efn_fps_drawHandle = addMissionEventHandler ["Draw3D", efn_fps_fnc_drawFps];
    } else {
        systemChat "turn off";
        removeMissionEventHandler ["Draw3D", efn_fps_drawHandle];
        efn_fps_drawHandle = nil;
    };
    systemChat "out";
};
