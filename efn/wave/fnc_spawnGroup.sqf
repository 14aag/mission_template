#include "script_component.hpp"
params ["_sideName", "_vehicles", "_units", "_formation", "_behavior", "_combatMode", "_speedMode", "_waypoints", "_currentWaypoint"];
TRACE_1("spawnGroup", _this);

private _group = createGroup [_sideName, true];
private _spawned = [];
{
    _spawned pushBack ([_group, _x] call FUNC(spawnVehicle));
} forEach _vehicles;
_spawned append (_units apply { [_group, _x] call FUNC(spawnUnit); });
{
    _x addCuratorEditableObjects [_spawned, true];
} forEach allCurators;

_group setFormation _formation;
_group setBehaviour _behavior;
_group setCombatMode _combatMode;
_group setSpeedMode _speedMode;

{
    private _waypoint =	if (_forEachIndex == 0) then {
        [_group, 0];
    } else {
        _group addWaypoint [[0,0,0], -1];
    };

    _x params ["_pos", "_type", "_name", "_description", "_waypointFormation", "_waypointBehavior", "_waypointCombatMode", "_waypointSpeed", "_waypointTimeout", "_waypointCompletionRadius", "_waypointStatements", "_waypointScript"];
    _waypoint setWaypointPosition [_pos, -1];
    _waypoint setWaypointType _type;
    _waypoint setWaypointName _name;
    _waypoint setWaypointDescription _description;
    _waypoint setWaypointFormation _waypointFormation;
    _waypoint setWaypointBehaviour _waypointBehavior;
    _waypoint setWaypointCombatMode _waypointCombatMode;
    _waypoint setWaypointSpeed _waypointSpeed;
    _waypoint setWaypointTimeout _waypointTimeout;
    _waypoint setWaypointCompletionRadius _waypointCompletionRadius;
    _waypoint setWaypointStatements _waypointStatements;
    _waypoint setWaypointScript _waypointScript;
} forEach _waypoints;

_group setCurrentWaypoint [_group, _currentWaypoint];

_group
