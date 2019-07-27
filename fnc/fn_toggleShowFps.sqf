with uiNamespace do {
    private _isAdmin = serverCommandAvailable "#kick";
    private _isZeus = !(isNull (findDisplay 312));

    if (hasInterface && (_isAdmin || _isZeus)) then {
        if (!(uiNamespace getVariable ["efn_fps_show", false])) then {
            uiNamespace setVariable ["efn_fps_show", true];
            efn_fpsDrawHandler = addMissionEventHandler ["Draw3D", {_this call efn_fnc_drawFps;}];
        } else {
            uiNamespace setVariable ["efn_fps_show", false];
            removeMissionEventHandler ["Draw3D", efn_fpsDrawHandler];
            efn_fpsDrawHandler = nil;
        };
    };
};
