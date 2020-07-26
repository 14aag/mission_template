#include "script_component.hpp"

_this findIf { _x isKindOf "Land" && {!(isNull (isVehicleCargo _x))} } != -1
