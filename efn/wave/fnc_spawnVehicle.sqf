#include "script_component.hpp"
params ["_group", "_template"];
_template params ["_type", "_special", "_pos", "_dir", "_up", "_fuel", "_damage", "_hitPointsDamage", "_inventory", "_magazines", "_pylonInfo", "_crew"];

private _vehicle = createVehicle [_type, [0, 0, 0], [], 0, _special];
_vehicle setVariable [QEGVAR(persistence,excluded), true];
_vehicle setVectorDirAndUp [_dir, _up];
_vehicle setPosASL _pos;
_vehicle setFuel _fuel;

_vehicle setDamage _damage;
{
    _vehicle setHitIndex [_forEachIndex, _x, false];
} forEach _hitPointsDamage;

[_vehicle, _inventory] call EFUNC(persistence,setContainerInventory);

{
    _vehicle removeMagazineTurret (_x select [0, 2]);
} forEach magazinesAllTurrets _vehicle;
{
    _vehicle addMagazineTurret _x;
} forEach _magazines;

{
    _x params ["_pylonIndex", "", "_turretPath", "_magazine", "_ammoCount"];

    _vehicle setPylonLoadOut [_pylonIndex, str _magazine, false, _turretPath];
    _vehicle setAmmoOnPylon [_pylonIndex, _ammoCount]; 
} forEach _pylonInfo;

{
    _x params ["_template", "_role", "_cargoIndex", "_turretPath"];
    private _unit = [_group, _template] call FUNC(spawnUnit);
    switch (toLower _role) do {
        case "driver": {
            if (getText (configOf _unit >> "simulation") == "UAVPilot") then {
                _unit moveInAny _vehicle;
            } else {
                _unit moveInDriver _vehicle;
            };
        };
        case "commander": {
            _unit moveInCommander _vehicle;
        };
        case "gunner": {
            _unit moveInGunner _vehicle;
        };
        case "turret": {
            _unit moveInTurret [_vehicle, _turretPath];
        };
        case "cargo": {
            _unit moveInCargo [_vehicle, _cargoIndex];
            _unit assignAsCargoIndex [_vehicle, _cargoIndex];
        };
    };
} forEach _crew;

_vehicle
