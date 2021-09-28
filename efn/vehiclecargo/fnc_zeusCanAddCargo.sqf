#include "script_component.hpp"

count _this > 0 && {_this findIf {
    !(_x isKindOf "AllVehicles" &&
    {!(_x isKindOf "CAManBase")} &&
    {isNull (_x getVariable [QGVAR(storage), objNull])} &&
    {!(_x getVariable [QGVAR(hasCargo), false])} &&
    {(crew _x) isEqualTo []} &&
    {alive _x} &&
    {!(isEngineOn _x)})
} == -1}
