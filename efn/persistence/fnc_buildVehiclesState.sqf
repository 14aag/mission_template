#include "script_component.hpp"

private _allVehicles = vehicles select {
    (_x isKindOf "AllVehicles") &&
    {!(_x getVariable [QGVAR(excluded),false])}
};

_allVehicles apply {
    private _vehicle = _x;
    private _damage = getAllHitPointsDamage _vehicle;
    if (count _damage == 3) then { _damage deleteAt 1; };
    private _pylonData = [];
    /*
    {
        _pylonData pushBack [_foreachIndex + 1, _x, _vehicle ammoOnPylon (_forEachIndex + 1)];
    } forEach getPylonMagazines _vehicle;
    */

    [
        typeOf _vehicle,
        vehicleVarName _vehicle,
        getPosASL _vehicle,
        [vectorDir _vehicle, vectorUp _vehicle],
        alive _vehicle,
        damage _vehicle,
        _damage,
        [_vehicle] call FUNC(getInventory),
        fuel _vehicle,
        (magazinesAllTurrets _vehicle) apply { [_x select 0, _x select 1, _x select 2] },
        _pylonData
    ]
}
