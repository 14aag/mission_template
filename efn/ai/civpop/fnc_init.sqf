#include "script_component.hpp"

params [["_logic", objNull, [objNull]], ["_width", 100, [0]], ["_height", 100, [0]], ["_unitTypes", "altis", ["", []]], ["_unitCount", 15, [0]]];

if (!isServer) exitWith {};

private _pos = getPosATL _logic;
private _area = [_pos, _width, _height];
private _radius = (_width max _height) * 1.415;
private _buildings = nearestObjects [_pos, ["House", "CBA_BuildingPos"], _radius] inAreaArray _area;
private _activation = _radius + 650;

_logic setVariable [QGVAR(activation), _activation];
_logic setVariable [QGVAR(deactivation), _activation + 100];
_logic setVariable [QGVAR(buildings), _buildings];
_logic setVariable [QGVAR(count), _unitCount];
if (_unitTypes isEqualType "") then {
	_unitTypes = [_unitTypes] call FUNC(getUnitTypes);
};
_logic setVariable [QGVAR(unitTypes), _unitTypes];

GVAR(centers) pushBack _logic;
