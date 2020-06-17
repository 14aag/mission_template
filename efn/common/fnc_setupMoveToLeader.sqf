#include "script_component.hpp"
params ["_newUnit", "_oldUnit"];

if (!isNull _oldUnit) then {
    private _id = _oldUnit getVariable [QGVAR(tpId), -1];
    if (_id >= 0) then {
        _oldUnit removeAction _id;
    };
};

if (CBA_missionTime > GVAR(missionStartTime)) exitWith {};

private _id = _newUnit addAction [
    "Move to leader",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        _target removeAction _actionId;
        _target setPosASL (getPosASL leader _target);
        _target setVariable [QGVAR(tpId), nil];
    },
    nil,
    1.5,
    false,
    true,
    "",
    QUOTE(CBA_missionTime < GVAR(missionStartTime) && {_originalTarget != leader _originalTarget})
];

_newUnit setVariable [QGVAR(tpId), _id];
[{ CBA_missionTime > GVAR(missionStartTime) || !(alive (_this select 0)) }, {
    params ["_unit"];
    private _id = _unit getVariable [QGVAR(tpId), -1];
    if (_id >= 0) then {
        _unit removeAction _id;
    };
    _unit setVariable [QGVAR(tpId), nil];
}, [_newUnit]] call CBA_fnc_waitUntilAndExecute;

nil
