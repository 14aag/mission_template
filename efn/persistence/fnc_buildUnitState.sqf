#include "script_component.hpp"

params ["_unit"];

private _loadout = if (GVAR(saveLoadout)) then {
    private _ret = _unit call FUNC(getSanitizedUnitLoadout);
    if !(alive _unit) then {
        _ret = _unit getVariable [QGVAR(loadout), _ret]
    };
    _ret
} else {objNull};

private _chestpack = if (GVAR(saveLoadout)) then { _unit getVariable ["bocr_main_chestpack", []] } else {[]};
if !(_chestpack isEqualTo []) then {
    _chestpack set [0, _chestpack select 0 select 0];
    _chestpack deleteAt 1;
    _chestpack set [2, []];
};

private _earplugs = GVAR(saveLoadout) && _unit getVariable ["ACE_hasEarPlugsIn", false];

private _pos = if (GVAR(savePosition) && alive _unit && (vehicle _unit) == _unit) then {[getDir _unit, getPosASL _unit]} else {objNull};

[[_loadout, _pos, _chestpack, _earplugs], GVAR(runCount)]
