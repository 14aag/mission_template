#include "script_component.hpp"

GVAR(zeusMarkers) = allMapMarkers select { _x find "_Z" != -1 };
[0] call FUNC(setZeusMarkerVisibility);
