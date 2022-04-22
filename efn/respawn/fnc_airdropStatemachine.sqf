#include "script_component.hpp"
#define PASSENGER_DELAY 0.4

GVAR(idleSpots) = allMapMarkers select { (toLower _x) find QGVAR(airdrop_loiter) == 0 } apply { markerPos _x };
GVAR(dropzones) = allMapMarkers select { (toLower _x) find QGVAR(airdrop_dropzone) == 0 };
publicVariable QGVAR(dropzones);

GVAR(stateMachine) = [{
    GVAR(vehicles) = GVAR(vehicles) select { _x isKindOf "Air" };
    GVAR(vehicles)
}] call CBA_statemachine_fnc_create;

[GVAR(stateMachine), {
    if (fuel _this < 0.5) then {
        ["zen_common_setFuel", [_this, 1], _this] call CBA_fnc_targetEvent;
    };
}, {
    private _group = group _this;
    [_group] call CBA_fnc_clearWaypoints;
    _this limitSpeed 350;
    _this flyInHeight 3000;
    _this flyInHeightASL [3000, 3000, 3000];

    private _wp = _group addWaypoint [[GVAR(idleSpots), _this] call BIS_fnc_nearestPosition, 150];
    _wp setWaypointType "LOITER";
    _wp setWaypointLoiterRadius 1000;
    _wp setWaypointLoiterAltitude 3000;
    _wp setWaypointLoiterType "CIRCLE";
    _wp setWaypointBehaviour "CARELESS";

    private _driver = driver _this;
    _driver setSkill 1;
    _driver allowFleeing 0;

}, {}, "idle"] call CBA_statemachine_fnc_addState;

[GVAR(stateMachine), {}, {
    private _players = (crew _this) select { isPlayer _x && {alive _x} };
    private _dropzones = _players apply { _x getVariable [QGVAR(dropzone), ""]; };
    _dropzones = _dropzones arrayIntersect _dropzones;

    private _target = [_dropzones, _this] call BIS_fnc_nearestPosition;
    _this setVariable [QGVAR(currentDropzone), _target];
    private _targetPos = markerPos _target;
    private _targetDir = markerDir _target;
    private _approachPoint = _targetPos getPos [4000, _targetDir - 180];
    private _reverseApproach = _targetPos getPos [4000, _targetDir];
    if ((_reverseApproach distance2D _this) < (_approachPoint distance2D _this)) then {
        _approachPoint = _reverseApproach;
        _targetDir = _targetDir - 180;
    };

    private _dropPoint = _approachPoint getPos [3500, _targetDir];
    private _exitPoint = _targetPos getPos [2000, _targetDir];

    private _group = group _this;
    [_group] call CBA_fnc_clearWaypoints;

    private _wp = _group addWaypoint [_approachPoint, 0];
    _wp setWaypointType "MOVE";
    _wp setWaypointBehaviour "CARELESS";
    _wp setWaypointStatements ["true", QUOTE((vehicle leader this) limitSpeed 240)];

    _wp = _group addWaypoint [_dropPoint, 0];
    _wp setWaypointType "MOVE";
    _wp setWaypointBehaviour "CARELESS";

    _wp = _group addWaypoint [_exitPoint, 0];
    _wp setWaypointType "MOVE";
    _wp setWaypointBehaviour "CARELESS";
    _wp setWaypointCompletionRadius 200;
}, {}, "approach"] call CBA_statemachine_fnc_addState;

[GVAR(stateMachine), {
    private _passengers = _this getVariable [QGVAR(ejectQueue), []];
    private _nextEject = _this getVariable [QGVAR(nextEject), CBA_missionTime];
    if (_passengers isNotEqualTo [] && {CBA_missionTime >= _nextEject}) then {
        private _unit = _passengers deleteAt 0;
        ["zen_common_unassignVehicle", _unit, _unit] call CBA_fnc_targetEvent;
        [QGVAR(respawn), [], _unit] call CBA_fnc_targetEvent;

        moveOut _unit;

        _this setVariable [QGVAR(nextEject), CBA_missionTime + PASSENGER_DELAY];
        _this setVariable [QGVAR(ejectQueue), _passengers];
    };
}, {
    private _dropzone = _this getVariable [QGVAR(currentDropzone), ""];
    private _queue = (crew _this) select {
        isPlayer _x &&
        {alive _x} &&
        {_x getVariable [QGVAR(dropzone), ""] == _dropzone}
    };
    _this setVariable [QGVAR(ejectQueue), _queue];
}, {}, "drop"] call CBA_statemachine_fnc_addState;

[GVAR(stateMachine), "idle", "approach", {
    (crew _this) findIf { isPlayer _x && {alive _x} && {_x getVariable [QGVAR(dropzone), ""] != ""} } != -1
}] call CBA_statemachine_fnc_addTransition;

[GVAR(stateMachine), "approach", "idle", {
    private _group = group _this;
    (currentWaypoint _group) >= (count waypoints _group)
}] call CBA_statemachine_fnc_addTransition;

[GVAR(stateMachine), "approach", "drop", {
    (currentWaypoint group _this > 0) && {(_this distance2D (markerPos (_this getVariable QGVAR(currentDropzone)))) < RESPAWN_JUMP_DISTANCE}
}] call CBA_statemachine_fnc_addTransition;

[GVAR(stateMachine), "drop", "idle", {
    private _group = group _this;
    (currentWaypoint _group) >= (count waypoints _group);
}] call CBA_statemachine_fnc_addTransition;
