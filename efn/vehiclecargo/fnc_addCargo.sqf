#include "script_component.hpp"
params ["_vehicle", "_cargo"];

private _assignedCargo = _vehicle getVariable [QGVAR(assignedCargo), []];
{
    if !(isNull _x) then {
        _assignedCargo pushBackUnique _x;
    };
} forEach _cargo;

private _observedHitPointNames = [];
{
    private _names = getAllHitPointsDamage _x param [0, []];
    if (_observedHitPointNames isEqualTo []) then {
        _observedHitPointNames = _names;
    } else {
        _observedHitPointNames = _observedHitPointNames arrayIntersect _names;
    };
} forEach _assignedCargo;

_vehicle setVariable [QGVAR(assignedCargo), _assignedCargo, true];
_vehicle setVariable [QGVAR(observedHitPointNames), _observedHitPointNames];
[QGVAR(initCargo), [_assignedCargo, _vehicle]] call CBA_fnc_globalEventJIP;

{
    _x setVariable [QGVAR(storage), _vehicle, true];
    [QGVAR(loadCargo), [_vehicle, _x]] call CBA_fnc_localEvent;
} forEach _cargo;
