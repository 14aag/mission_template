#include "script_component.hpp"
params ["_vehicle"];

private _pylonMagazines = getPylonMagazines _vehicle;
[
    typeOf _vehicle,
    ["CAN_COLLIDE", "FLY"] select (_vehicle isKindOf "Air" && {isEngineOn _vehicle} && {getPos _vehicle select 2 > 5}),
    getPosASL _vehicle,
    vectorDir _vehicle,
    vectorUp _vehicle,
    fuel _vehicle,
    damage _vehicle,
    getAllHitPointsDamage _vehicle param [2, []],
    [_vehicle] call EFUNC(persistence,getInventory),
    magazinesAllTurrets _vehicle select {
        !(_x select 0 in _pylonMagazines)
    } apply {
        _x select [0, 3]
    },
    getAllPylonsInfo _vehicle,
    fullCrew _vehicle apply {
        _x params ["_unit", "_role", "_cargoIndex", "_turretPath"]; 
        [
            [_unit] call FUNC(processUnit),
            _role,
            _cargoIndex,
            _turretPath
        ]
    }
]