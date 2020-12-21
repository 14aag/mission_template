#include "script_component.hpp"
params ["_vehicle", "_timer", "_tickets"];

private _respawnData = [
    _vehicle,
    _timer,
    _tickets,
    typeOf _vehicle,
    getPosASL _vehicle,
    [vectorDir _vehicle, vectorUp _vehicle],
    [_vehicle] call FUNC(getInventory)
];

[_vehicle, "killed", {
    _thisArgs params ["", "_timer"];
    [{
        params ["_vehicle"];
        deleteVehicle _vehicle;
        [{
            params ["", "", "", "_type", "_pos", "", ""];
            !((_pos findEmptyPosition [0, 1, _type]) isEqualTo []);
        }, {
            params ["", "_timer", "_tickets", "_type", "_pos", "_vectors", "_inventory"];
            _vehicle = createVehicle [_type, [0,0,0], [], 0, "CAN_COLLIDE"];

            _vehicle setPosASL _pos;
            _vehicle setVectorDirAndUp _vectors;
            [_vehicle, _inventory] call EFUNC(persistence,setContainerInventory);

            _tickets = (_tickets - 1) max -1;
            if (_tickets != 0) then {
                [_vehicle, _timer, _tickets] call FUNC(initVehicleRespawn);
            };
        }, _this] call CBA_fnc_waitUntilAndExecute;
    }, _thisArgs, _timer] call CBA_fnc_waitAndExecute;
}, _respawnData] call CBA_fnc_addBISEventHandler;
