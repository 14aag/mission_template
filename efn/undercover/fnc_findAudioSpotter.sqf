#include "script_component.hpp"
params ["_unit", "_spotters", "_audible"];

private _audibleDistance = 20 max (_audible * EFN_UNDERCOVER_AUDIBLE_TO_DISTANCE);
systemChat format ["audible distance %1", _audibleDistance];

if (count _spotters > 0 && {(_spotters select 0 distance _unit) < _audibleDistance}) exitWith {
	0
};

-1
