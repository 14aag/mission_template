#include "script_component.hpp"
params ["_group"];

if (_group isEqualType objNull) then {
    _group = group _group;
};

private _sideName = side _group;
private _formation = formation _group;
private _behavior = behaviour leader _group;
private _combatMode = combatMode _group;
private _speedMode = speedMode _group;

private _waypoints = waypoints _group apply {
    [
        AGLToASL waypointPosition _x,
        waypointType _x,
        waypointName _x,
        waypointDescription _x,
        waypointFormation _x,
        waypointBehaviour _x,
        waypointCombatMode _x,
        waypointSpeed _x,
        waypointTimeout _x,
        waypointCompletionRadius _x,
        waypointStatements _x,
        waypointScript _x
    ];
};
private _currentWaypoint = currentWaypoint _group;

private _vehicles = units _group select { vehicle _x != _x } apply { vehicle _x };
_vehicles = (_vehicles arrayIntersect _vehicles) apply { [_x] call FUNC(processVehicle) };

private _units = units _group select { vehicle _x == _x } apply { [_x] call FUNC(processUnit); };

[_sideName, _vehicles, _units, _formation, _behavior, _combatMode, _speedMode, _waypoints, _currentWaypoint];
