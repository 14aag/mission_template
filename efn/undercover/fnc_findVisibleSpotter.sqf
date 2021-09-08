#include "script_component.hpp"
params ["_unit", "_spotters"];

_spotters findIf {
	private _lookDir = [0, 0, 0] getDir eyeDirection _x;
	private _dirToUnit = _x getDir _unit;

	// in field of view (150 degrees) and visible
	abs (_lookDir - _dirToUnit) < 75 && {[_x, "VIEW", _unit] checkVisibility [eyePos _x, eyePos _unit] >= 0.5}
}
