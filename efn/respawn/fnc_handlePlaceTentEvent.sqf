#include "script_component.hpp"

params ["_unit", "_pos"];

private _tent = [_unit] call FUNC(getTent);
if !(isNull _tent) then {
    if (_tent distance2D _pos < GVAR(minDistance)) exitWith {
        [QGVAR(notify), "Too close to current tent location", _unit] call CBA_fnc_targetEvent;
    };
    if (((_tent getVariable [QGVAR(cooldown), -GVAR(tentCooldown)]) + GVAR(tentCooldown)) > CBA_missionTime) exitWith {
        [QGVAR(notify), "Respawn tent placement on cooldown", _unit] call CBA_fnc_targetEvent;
    };
    deleteVehicle _tent;
    [FUNC(handlePlaceTentEvent), _this] call CBA_fnc_execNextFrame;
} else {
    private _tent = [_unit, true] call FUNC(getTent);
    if !(isNull _tent) then {
        _tent setVariable [QGVAR(tickets), GVAR(ticketCount)];
        _tent setPosATL _pos;
        [QGVAR(tent_placed), [], _unit] call CBA_fnc_targetEvent;
    };
};

nil
