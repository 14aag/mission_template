#include "script_component.hpp"
params ["_center", "_distance"];

allPlayers findIf { _x distance2D _center < _distance } != -1
