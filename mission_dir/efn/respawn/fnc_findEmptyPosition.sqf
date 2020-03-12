#include "script_component.hpp"

params ["_unit"];

private _dir = getDir _unit;
private _height = (getPosATL _unit) select 2;
private _pos = _unit getPos [1.5, _dir];
_pos set [2, _height];

_pos findEmptyPosition [2, 10, "B_Soldier_F"];
