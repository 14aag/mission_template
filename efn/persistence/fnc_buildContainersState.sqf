#include "script_component.hpp"

private _containers = vehicles select {
    (_x isKindOf "ThingX") &&
    {!(_x isKindOf "Static") &&
    {!(_x getVariable [QGVAR(excluded),false]) &&
    {alive _x &&
    {(getNumber (configFile >> "CfgVehicles" >> typeOf _x >> "maximumLoad")) > 0}}}}
};

_containers apply {
    [
        typeOf _x,
        vehicleVarName _x,
        getPosASL _x,
        [vectorDir _x, vectorUp _x],
        damage _x,
        [_x] call FUNC(getInventory)
    ]
}
