#include "script_component.hpp"

params ["_unit", "_pos"];

private _tent = [_unit, true] call FUNC(getTent);
if !(isNull _tent) then {
    private _tickets = _tent getVariable QGVAR(tickets);
    if ((!isNil "_tickets") && (_tent distance2D _pos < GVAR(minDistance))) exitWith {
        [QGVAR(notify), "Too close to current tent location", _unit] call CBA_fnc_targetEvent;
    };

    _tent setVariable [QGVAR(tickets), GVAR(ticketCount)];
    _tent setPos _pos;
    [QGVAR(tent_placed), [], _unit] call CBA_fnc_targetEvent;
};

nil