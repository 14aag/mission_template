#include "script_component.hpp"
params ["_name"];

private _logic = GVAR(waves) get _name;
if (isNil "_logic") exitWith {
    ERROR_1("wave not found", _name);
};

private _template = _logic getVariable [QGVAR(template), []];
if (_template isEqualTo []) exitWith {
    ERROR_1("no template for wave", _name);
};

_template apply { _x call FUNC(spawnGroup) };
