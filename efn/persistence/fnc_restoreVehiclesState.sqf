#include "script_component.hpp"
params ["_vehicleStates"];

{
    _x params ["_type", "_varName", "_pos", "_vectorDirAndUp", "_alive", "_damage", "_hitpoints", "_inventory", "_fuel", "_magazines", "_pylons"];

    private _vehicle = objNull;
    if (_varName != "") then {
        private _found = call compile _varName;
        if (!isNil "_found" && {typeOf _found isEqualTo _type}) then {
            _vehicle = _found;
        };
    };

    if (isNull _vehicle) then {
        _vehicle = createVehicle [_type, [0,0,0], [], 0, "CAN_COLLIDE"];
    };

    if (!isNull _vehicle) then {
        _vehicle setPosASL _pos;
        _vehicle setVectorDirAndUp _vectorDirAndUp;
        if (!_alive) then {
            _vehicle setVariable ["ace_cookoff_enableAmmoCookoff", false, true];
        };
        _vehicle setDamage [_damage, false];
        _hitpoints params ["_names", "_hitDamages"];
        {
            _vehicle setHitPointDamage [_x, _hitDamages select _forEachIndex, false];
        } forEach _names;
        if (_alive) then {
            [_vehicle, _inventory] call FUNC(setContainerInventory);
        };
        _vehicle setFuel _fuel;

        {
            _x params ["_class", "_path"];
            _vehicle removeMagazineTurret [_class, _path];
        } forEach (magazinesAllTurrets _vehicle);

        {
            _x params ["_class", "_path", "_count"];
            _vehicle addMagazineTurret [_class, _path, _count];
        } forEach _magazines;
    };
} forEach _vehicleStates;
