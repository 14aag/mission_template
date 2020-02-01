#include "script_component.hpp"

params ["_logic"];
TRACE_1("do spawn", nil);

private _buildings = _logic getVariable QGVAR(locations);
private _location = _buildings deleteAt 0;
if (isNil "_location") then {
    _location = getPosATL _logic;
} else {
    private _bps = _location buildingPos -1;
    if (count _bps > 0) then {
        _location = selectRandom _bps;
    } else {
        _location = getPosATL _logic;
    };
};

private _unitTypes = _logic getVariable [QGVAR(unitTypes), []];
private _unitType = selectRandom _unitTypes;
private _unit = [_location, _unitType] call FUNC(spawn);
_unit setVariable [QGVAR(logic), _logic];
GVAR(civilians) pushBack _unit;

private _units = _logic getVariable [QGVAR(units), []];
_units pushBack _unit;
_logic setVariable [QGVAR(units), _units];
_logic setVariable [QGVAR(locations), _buildings];
