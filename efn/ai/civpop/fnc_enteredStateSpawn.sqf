#include "script_component.hpp"

params ["_logic"];
TRACE_1("enter spawn", nil);
private _buildings = _logic getVariable [QGVAR(buildings), []] select { !((_x buildingPos -1) isEqualTo []) };
_logic setVariable [QGVAR(locations), [_buildings] call CBA_fnc_shuffle];