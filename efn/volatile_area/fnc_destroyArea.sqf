#include "script_component.hpp"
params ["_pos", "_removables"];
TRACE_1("", _removables);
createVehicle ["R_MRAAWS_HE_F", _pos, [], 0, "CAN_COLLIDE"];

[{
    createVehicle ["M_Titan_AP", _this, [], 0, "CAN_COLLIDE"];
}, [_pos, random 5] call BIS_fnc_randomPosTrigger, random [0.1, 0.2, 0.3]] call CBA_fnc_waitAndExecute;

private _delayedExplosions = floor random 17 + 3;
for "_i" from 0 to _delayedExplosions do {
    [{
        createVehicle ["M_120mm_cannon_ATGM", _this, [], 0, "CAN_COLLIDE"];
    }, [_pos, random 10] call BIS_fnc_randomPosTrigger, random [0.4, 1.5, 10]] call CBA_fnc_waitAndExecute;
};

_delayedExplosions = floor random 13 + 6;
for "_i" from 0 to _delayedExplosions do {
    [{
        createVehicle [selectRandom ["GrenadeHand","mini_Grenade"], _this, [], 0, "CAN_COLLIDE"];
    }, [_pos, random 15] call BIS_fnc_randomPosTrigger, (random [2, 7.5, 20] - 5) max 0.1] call CBA_fnc_waitAndExecute;
};

[{
    {
        deleteVehicle _x;
    } forEach _this;
}, _removables, 0.1] call CBA_fnc_waitAndExecute;

[{
    createVehicle ["test_EmptyObjectForFireBig", _this, [], 0, "CAN_COLLIDE"];
}, _pos, 0.15] call CBA_fnc_waitAndExecute;

