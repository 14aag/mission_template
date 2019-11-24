#include "script_component.hpp"

params ["_unit"];

private _tent = [_unit] call FUNC(getTent);
if (isNull _tent) exitWith {
    [QGVAR(notify), "Respawn tent not found", _unit] call CBA_fnc_targetEvent;
};

private _tickets = _tent getVariable [QGVAR(tickets), 0];
if (_tickets <= 0) exitWith {
    [QGVAR(notify), "Respawn tent out of tickets", _unit] call CBA_fnc_targetEvent;
};

private _pos = (getPosATL _tent) findEmptyPosition [1, 30, "B_Soldier_F"];
if (_pos isEqualTo []) exitWith { diag_log "no valid position found"; };
private _entities = (ASLToAGL getPosASL _tent) nearEntities ["Man", 100];
private _enemies = _entities select { [side _unit, side _x] call BIS_fnc_sideIsEnemy };
private _hasFriendlies = _entities findIf { side _x == side _unit } >= 0;

if (!(_enemies isEqualTo []) && (_enemies findIf { _pos distance _x < 35 } >= 0 || {!_hasFriendlies})) exitWith {
    [QGVAR(notify), "Respawn tent not secure", _unit] call CBA_fnc_targetEvent;
};

//private _eyePos = (getPosASL _tent) vectorAdd [0,0,1];
//if (!_hasFriendlies && _enemies findIf {[_x, "VIEW"] checkVisibility [eyePos _x, _eyePos] >= 0.5} >= 0) exitWith {};

_unit setPosATL _pos;
_tickets = _tickets - 1;
_tent setVariable [QGVAR(tickets), _tickets];

if (_tickets <= 0) then {
    _tent setPos [0,0,0];
    [QGVAR(notify), "Respawn tent out of tickets", (leader _unit)] call CBA_fnc_targetEvent;
};

nil

