#include "script_component.hpp"

private _vehicles = _this select {
    _x isKindOf "AllVehicles" &&
    {!(_x isKindOf "CAManBase")} &&
    {isNull (_x getVariable [QGVAR(storage), objNull])} &&
    {!(_x getVariable [QGVAR(hasCargo), false])}
};

[_vehicles, {
    params ["_successful", "_vehicles", "_position"];
    if (_successful) then {
        curatorMouseOver params ["_type", "_entity"];
        if (_type == "OBJECT" &&
            {_entity isKindOf "AllVehicles"} &&
            {!(_entity isKindOf "CAManBase")} &&
            {_entity getVariable [QGVAR(hasCargo), false]} &&
            {alive _entity}) then {
            [QGVAR(addCargo), [_entity, _vehicles]] call CBA_fnc_serverEvent;
        } else {

        };
    };
}] call zen_common_fnc_selectPosition;
