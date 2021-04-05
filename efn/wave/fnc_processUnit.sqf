#include "script_component.hpp"
params ["_unit"];

[
    typeOf _unit,
    getPosASL _unit,
    getDir _unit,
    rank _unit,
    skill _unit,
    unitPos _unit,
    leader _unit == _unit,
    getUnitLoadout _unit
]
