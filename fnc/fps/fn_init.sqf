if !(hasInterface) exitWith {};

[efn_fps_fnc_updateFps, 10, []] call CBA_fnc_addPerFrameHandler;
["14aag_zeus_fps", "show_fps", "Toggle FPS overlay", "", efn_fps_fnc_toggleShowFps] call CBA_fnc_addKeybind;

