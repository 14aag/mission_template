#include "script_component.hpp"

params ["_location", "_unitType"];

private _agent = createAgent [_unitType, _location, [], 0, "CAN_COLLIDE"];
_agent disableAI "FSM";
_agent setBehaviour "CARELESS";
_agent forceWalk true;

[_agent, "FiredNear", {
	params ["_unit"];
	TRACE_1("fired near", _unit);
	_unit setVariable [QGVAR(firedTime), CBA_missionTime];
	[QGVAR(firedNear), [_unit]] call CBA_fnc_localEvent;
}, []] call CBA_fnc_addBISEventHandler;

_agent