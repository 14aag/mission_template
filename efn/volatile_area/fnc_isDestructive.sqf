#include "script_component.hpp"
params ["_pos", "_object", "_threshold", "_volatile"];
TRACE_1("isDestructive", _this);

private _type = typeOf _object;
private _cfg = configFile >> "CfgAmmo" >> _type;
if (!isClass _cfg) exitWith { false };

private _explosive = [_cfg >> "explosive", "NUMBER", 0] call CBA_fnc_getConfigEntry;
private _ret = false;

// TODO: stupid workaround for figuring out if penetrating rockets were fired (the ammo we find is the submunition of the rocket which isn't explosive)
if (_explosive == 0 && {(_type find "_penetrator") != -1}) then {
    _type = _type select [0, count _type - 11];
    _cfg = configFile >> "CfgAmmo" >> _type;
    if (!isClass _cfg) then {
        _type = _type + "_rocket";
        _cfg = configFile >> "CfgAmmo" >> _type;
    };

    _explosive = [_cfg >> "explosive", "NUMBER", 0] call CBA_fnc_getConfigEntry;
};

TRACE_3("is explosive", _explosive, _threshold, _type);
if (_explosive >= 0.5) then {
    private _explosiveRange = [_cfg >> "indirectHitRange", "NUMBER", 0] call CBA_fnc_getConfigEntry;
    private _distance = (_pos distance _object) - 3;
    TRACE_2("range", _explosiveRange, _distance);
    if (_explosiveRange > _distance) then {
        private _damage = [_cfg >> "hit", "NUMBER", 0] call CBA_fnc_getConfigEntry;
        private _roll = random 1;
        if (_roll < _volatile) then {
            TRACE_2("", _roll, _volatile);
            _threshold = 0;
        };
        _ret = _damage >= _threshold;
        TRACE_3("", _ret, _damage, _threshold);
    };
};

_ret