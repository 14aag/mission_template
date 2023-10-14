#include "script_component.hpp"

if (hasInterface) then {
    GVAR(requireAFMmode) = getMissionConfigValue [QGVAR(requireAFMmode), 0];
};
if (!hasInterface) exitWith {};
GVAR(missionStartTime) = getMissionConfigValue [QGVAR(missionStartTime), 0];
GVAR(disabledChannels) = [0, 1];
GVAR(currentChannel) = 3;
GVAR(currentMapChannel) = 3;

["CBA_loadingScreenDone", {
    setCurrentChannel GVAR(currentChannel);
}] call CBA_fnc_addEventHandler;

{
    _x enableChannel [false, true];
} forEach GVAR(disabledChannels);

/*
[missionNamespace, "Map", {
    params ["_open", ""];
    private _current = GVAR(currentMapChannel);
    if (_open) then {
        GVAR(currentChannel) = currentChannel;
    } else {
        GVAR(currentMapChannel) = currentChannel;
        _current = GVAR(currentChannel);
    };

    {
        _x enableChannel [false, _open]; // enable VON on map to allow markers on these channels
    } forEach GVAR(disabledChannels);

    setCurrentChannel _current;
}] call CBA_fnc_addBISEventHandler;
*/

["unit", FUNC(setupMoveToLeader), true] call CBA_fnc_addPlayerEventHandler;

private _fnc_setMoonBrightness = {
    params ["_brightness", "_color"];
    GVAR(personalMoon) setLightBrightness _brightness;
    GVAR(personalMoon) setLightColor _color;
    GVAR(personalMoon) setLightAmbient _color;
    GVAR(personalMoonColor) = _color;
    GVAR(personalMoonBrightness) = _brightness;
};

GVAR(personalMoon) = "#lightpoint" createVehicleLocal [0, 0, 0];
GVAR(personalMoon) setLightDayLight true;
[getMissionConfigValue [QGVAR(personalMoonBrightness), 0], [0.15, 0.15, 0.25]] call _fnc_setMoonBrightness;

[{
    private _camera = positionCameraToWorld [0, 0, 0];
    GVAR(personalMoon) setPosASL [_camera # 0, _camera # 1, -1000];
}] call CBA_fnc_addPerFrameHandler;

[QGVAR(configurePersonalMoon), _fnc_setMoonBrightness] call CBA_fnc_addEventHandler;
