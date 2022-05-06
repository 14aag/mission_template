#include "script_component.hpp"
params ["_target", "_distance", "_altitude", "_direction"];
if (!isServer) exitWith {};

private _spawnPos = _target getPos [_distance, 360 - _direction];
_spawnPos set [2, _altitude];

private _rhsHack = "CBA_NamespaceDummy" createVehicleLocal [0, 0, 0];
_rhsHack setVariable ["target_designated_valid", true];
_rhsHack setVariable ["target", _target];

private _missile = createVehicle ["rhs_ammo_kh55sh", _spawnPos, [], 0, "CAN_COLLIDE"];
_missile setPosATL _spawnPos;
_missile setDir _direction;

[_rhsHack, _rhsHack, "", "", "rhs_ammo_kh55sh", "", _missile] call RHS_fnc_tu95_missile_control;

[{isNull (_this#0)}, {
    deleteVehicle (_this#1);
}, [_missile, _rhsHack]] call CBA_fnc_waitUntilAndExecute;
