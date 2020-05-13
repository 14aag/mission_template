#include "script_component.hpp"
params ["_containerStates"];

{
    _x params ["_type", "_varName", "_pos", "_vectorDirAndUp", "_damage", "_inventory"];
    private _container = objNull;
    if (_varName != "") then {
        private _found = call compile _varName;
        if (!isNil "_found") then {
            _container = _found;
        };
    };

    if (isNull _container) then {
        _container = createVehicle [_type, [0,0,0], [], 0, "CAN_COLLIDE"];
    };

    if (!isNull _container) then {
        _container setPosASL _pos;
        _container setVectorDirAndUp _vectorDirAndUp;
        _container setDamage [_damage, false];
        [_container, _inventory] call FUNC(setContainerInventory);
    };
} forEach _containerStates;
