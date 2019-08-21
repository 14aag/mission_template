if (!isServer) exitWith {};

private _setVulnerable = {
    params ["_vulnerable"];
    {
        _x allowDamage _vulnerable;
        _x enableSimulationGlobal _vulnerable;
    } forEach vehicles;
};

[_setVulnerable, false, 0] call CBA_fnc_waitAndExecute;
[_setVulnerable, true, 60] call CBA_fnc_waitAndExecute;
