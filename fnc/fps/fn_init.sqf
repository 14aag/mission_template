#include "script_component.hpp"

if !(hasInterface) exitWith {};

[FUNC(updateFps), 10, []] call CBA_fnc_addPerFrameHandler;
["14aag_zeus_fps", "show_fps", "Toggle FPS overlay", "", FUNC(toggleShowFps)] call CBA_fnc_addKeybind;

