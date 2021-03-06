#include "script_component.hpp"

params ["_unit", ["_create", false]];

private _name = (group _unit) getVariable ["leader_name", ""];
if (_name isEqualTo "") exitWith { objNull };

private _tentName = format ["efn_respawn_tent_%1", _name];
private _tent = missionNamespace getVariable [_tentName, objNull];
if (isNull _tent && _create) then {
    private _sideTentType = if (side _unit == independent) then {
        "Misc_Backpackheap"
    } else {
        "Misc_Backpackheap"
    };

    _tent = _sideTentType createVehicle [0,0,0];
    missionNamespace setVariable [_tentName, _tent];
};

_tent
