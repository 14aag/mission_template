#include "script_component.hpp"
params ["_logic", "_name"];
TRACE_2("register wave",_logic,_name);

if (!isServer) exitWith {};

private _objects = synchronizedObjects _logic;
if (_objects isEqualTo []) exitWith {};

private _groups = _objects apply { group _x };
_groups = _groups arrayIntersect _groups;

[{CBA_missionTime > 0}, 
{
    params ["_logic", "_groups"];
    private _template = _groups apply {[_x] call FUNC(processGroup)};
    _logic setVariable [QGVAR(template), _template];
}, [_logic, _groups]] call CBA_fnc_waitUntilAndExecute;

_logic setVariable [QGVAR(name), _name];
GVAR(waves) set [_name, _logic];
