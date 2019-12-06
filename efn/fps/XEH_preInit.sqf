#include "script_component.hpp"
#include "XEH_PREP.hpp"

if !(hasInterface) exitWith {};

["14aag_zeus_fps", "show_fps", "Toggle FPS overlay", "", FUNC(toggleShowFps)] call CBA_fnc_addKeybind;
