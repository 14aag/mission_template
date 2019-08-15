params ["_unit"];

private _loadout = if (efn_saveLoadout) then {
    private _ret = _unit call efn_persistence_fnc_getSanitizedUnitLoadout;
    if !(alive _unit) then {
        _ret = _unit getVariable ["efn_persistence_loadout", _ret]
    };
    _ret
} else {objNull};

private _chestpack = if (efn_saveLoadout) then { _unit getVariable ["zade_boc_chestpack", []] } else {[]};
if !(_chestpack isEqualTo []) then {
    _chestpack set [0, _chestpack select 0 select 0];
    _chestpack deleteAt 1;
};

private _earplugs = efn_saveLoadout && _unit getVariable ["ACE_hasEarPlugsIn", false];

private _pos = if (efn_savePosition && alive _unit && (vehicle _unit) == _unit) then {[getDir _unit, getPosASL _unit]} else {objNull};

[_loadout, _pos, _chestpack, _earplugs]
