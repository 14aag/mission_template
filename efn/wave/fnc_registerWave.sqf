#include "script_component.hpp"
params ["_logic", "_name"];
TRACE_2("register wave",_logic,_name);

if (!isServer) exitWith {};

private _objects = synchronizedObjects _logic;
if (_objects isEqualTo []) exitWith {};

[{CBA_missionTime > 0}, 
{
    params ["_logic", "_objects"];
    private _template = [];
    {
        _template pushBack ([_x] call FUNC(processGroup));
        TRACE_1("remove groups",_logic);
        {
            private _veh = vehicle _x;
            deleteVehicle _x;
            if (!isNull _veh && {crew _veh isEqualTo []}) then {
                deleteVehicle _veh;
            };
        } forEach units group _x;
    } forEach _objects;

    _logic setVariable [QGVAR(template), _template];
}, [_logic, _objects]] call CBA_fnc_waitUntilAndExecute;

_logic setVariable [QGVAR(name), _name];
GVAR(waves) set [_name, _logic];
