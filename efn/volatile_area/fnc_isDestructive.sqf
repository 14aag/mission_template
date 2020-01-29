#include "script_component.hpp"
params ["_pos", "_object", "_threshold", "_volatile"];
TRACE_1("isDestructive", _this);

private _cfg = configFile >> "CfgAmmo";
private _explosive = ([_cfg >> (typeOf _object) >> "explosive", "NUMBER", 0] call CBA_fnc_getConfigEntry);
private _ret = false;

if (_explosive >= 0.5) then {
    TRACE_2("is explosive", _explosive, _threshold);
    private _explosiveRange = [_cfg >> (typeOf _object) >> "indirectHitRange", "NUMBER", 0] call CBA_fnc_getConfigEntry;
    private _distance = (_pos distance _object) - 3;
    TRACE_2("range", _explosiveRange, _distance);
    if (_explosiveRange > _distance) then {
        private _damage = [_cfg >> (typeOf _object) >> "hit", "NUMBER", 0] call CBA_fnc_getConfigEntry;
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