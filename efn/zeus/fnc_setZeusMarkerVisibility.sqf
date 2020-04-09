#include "script_component.hpp"
params ["_visibility"];

{
    _x setMarkerAlphaLocal _visibility;
} forEach GVAR(zeusMarkers);
