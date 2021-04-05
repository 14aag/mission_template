#include "script_component.hpp"
params ["_group", "_template"];
_template params ["_type", "_pos", "_dir", "_rank", "_skill", "_unitPos", "_isLeader", "_inventory"];
TRACE_1("spawnUnit", _this);

private _unit = _group createUnit [_type, [0, 0, 0], [], 0, "CAN_COLLIDE"];
_unit setPosASL _pos;
_unit setDir _dir;
_unit setRank _rank;
_unit setSkill _skill;
_unit setUnitPos _unitPos;
if (_isLeader) then {
	_group selectLeader _unit;
};

[{
	params ["_unit", "_inventory"];
	_unit setUnitLoadout _inventory
}, [_unit, _inventory]] call CBA_fnc_execNextFrame;

_unit
