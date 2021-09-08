#include "script_component.hpp"
params ["_group", "_undercover"];

{
    if (local _x) then {
        [_x, _undercover] call FUNC(monitorActivity);
    };
} forEach units _group;
