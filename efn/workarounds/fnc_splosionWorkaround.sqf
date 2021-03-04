#include "script_component.hpp"

if (!isDedicated) exitWith {};

private _setVulnerable = {
    params ["_vehicles", "_vulnerable"];
    {
        _x allowDamage _vulnerable;
        _x enableSimulationGlobal _vulnerable;
    } forEach _vehicles;
};

private _vehicles = vehicles select { simulationEnabled _x && isDamageAllowed _x };
[_setVulnerable, [_vehicles, false], 0] call CBA_fnc_waitAndExecute;
[_setVulnerable, [_vehicles, true], 60] call CBA_fnc_waitAndExecute;
