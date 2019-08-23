#include "script_component.hpp"

params ["_unit", "_pos"];

private _tent = [_unit, true] call FUNC(getTent);
if !(_tent isEqualTo objNull) then {
    _tent setVariable [QGVAR(tickets), GVAR(ticketCount)];
    _tent setPos _pos;
};

nil