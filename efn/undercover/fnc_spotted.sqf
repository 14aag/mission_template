#include "script_component.hpp"
params ["_unit", "_spotter"];

[_unit, false, true] call FUNC(setUndercover);
_spotter reveal [_unit, 1];
