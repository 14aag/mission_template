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

private _vehicles = _logic getVariable [QGVAR(vehicles), []];
private _vehicleTypes = _logic getVariable [QGVAR(vehicleTypes), []];
private _vehicleCount = _logic getVariable [QGVAR(vehicleCount), 0];
if (!(_vehicleTypes isEqualTo []) && {count _vehicles < _vehicleCount}) then {
    private _vehicleType = selectRandom _vehicleTypes;
    private _spot = [_vehicleType, _location] call FUNC(findParkingSpot);
    if !(_spot isEqualTo []) then {
        private _vehicle = [_spot, _vehicleType] call FUNC(spawnVehicle);
        _vehicles pushBack _vehicle;
        _logic setVariable [QGVAR(vehicles), _vehicles];
    };
};

nil
