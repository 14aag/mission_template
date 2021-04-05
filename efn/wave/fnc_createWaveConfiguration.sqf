#include "script_component.hpp"
params ["_name", ["_list", [], [[]]], ["_condition", {true}, [{}]], ["_minLifetime", 0, [0]], ["_looping", false, [true]]];
TRACE_1("create wave config",_this);
if (!isServer) exitWith {};

private _configuration = [] call CBA_fnc_createNamespace;
_configuration setVariable [QGVAR(list), _list];
_configuration setVariable [QGVAR(condition), _condition];
_configuration setVariable [QGVAR(minLifetime), _minLifetime];
_configuration setVariable [QGVAR(looping), _looping];

GVAR(waveConfigurations) set [_name, _configuration];
