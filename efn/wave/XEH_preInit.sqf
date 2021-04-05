#include "script_component.hpp"
#include "XEH_PREP.hpp"

if (!isServer) exitWith {};
GVAR(waves) = createHashMap;
GVAR(waveConfigurations) = createHashMap;
GVAR(active) = [];
GVAR(pfhId) = -1;
