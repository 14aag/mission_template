#include "script_component.hpp"

private _isAdmin = serverCommandAvailable "#kick";
private _isZeus = !isNull (getAssignedCuratorLogic player);

if (_isAdmin || _isZeus) then {
    if (isNil QGVAR(drawHandle)) then {
        GVAR(drawHandle) = addMissionEventHandler ["Draw3D", FUNC(drawFps)];
    } else {
        removeMissionEventHandler ["Draw3D", GVAR(drawHandle)];
        GVAR(drawHandle) = nil;
    };
};
