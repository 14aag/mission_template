#include "script_component.hpp"

private _isAdmin = serverCommandAvailable "#kick";
private _isZeus = !isNull (getAssignedCuratorLogic player);

systemChat format ["isAdmin %1 isZeus %2", _isAdmin, _isZeus];
if (_isAdmin || _isZeus) then {
    if (isNil QGVAR(drawHandle)) then {
        systemChat "turn on";
        GVAR(drawHandle) = addMissionEventHandler ["Draw3D", FUNC(drawFps)];
    } else {
        systemChat "turn off";
        removeMissionEventHandler ["Draw3D", GVAR(drawHandle)];
        GVAR(drawHandle) = nil;
    };
    systemChat "out";
};
