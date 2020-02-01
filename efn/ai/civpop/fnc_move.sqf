#include "script_component.hpp"
params ["_agent"];

if (!alive _agent) exitWith {};

private _logic = _agent getVariable [QGVAR(logic), objNull];
private _buildings = _logic getVariable [QGVAR(buildings), []];

private _building = selectRandom _buildings;
private _buildingPoss = _building buildingPos -1;
TRACE_1("move", _buildingPoss);
if (_buildingPoss isEqualTo []) then {
	_agent moveTo getPosATL _building;
} else {
	_agent moveTo (selectRandom _buildingPoss);
};

nil