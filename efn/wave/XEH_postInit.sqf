#include "script_component.hpp"

if (!isServer) exitWith {};
[{CBA_missionTime > 0 && {
    -1 == {
        private _template = _y getVariable QGVAR(template);
        if (isNil "_template") then {
            breakWith _forEachIndex;
        };
        -1
    } forEach GVAR(waves)
}}, {
    {
        TRACE_1("remove groups",_y);
        private _objects = synchronizedObjects _y;
        private _groups = _objects apply { group _x };
        _groups = _groups arrayIntersect _groups;
        {
            private _veh = vehicle _x;
            deleteVehicle _x;
            if (!isNull _veh && {crew _veh isEqualTo []}) then {
                deleteVehicle _veh;
            };
        } forEach flatten (_groups apply {units _x});
    } forEach GVAR(waves);
}] call CBA_fnc_waitUntilAndExecute;
