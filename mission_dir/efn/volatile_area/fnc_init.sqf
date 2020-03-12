#include "script_component.hpp"
params [["_item", objNull, [objNull]], ["_threshold", 50, [0]], ["_volatile", 0, [0]]];

if (!isServer) exitWith {};
if (isNull _item) exitWith {};
_volatile = (_volatile min 1) max 0;
private _items = synchronizedObjects _item;
private _pos = getPosATL _item;

[{
    (_this select 0) params ["_pos", "_removables", "_threshold", "_volatile"];
    if !((_pos nearObjects ["#explosion", 150]) isEqualTo []) then {
        TRACE_1("explosion", _removables);
        private _destructive = ((_pos nearObjects 150) - _removables) findIf { [_pos, _x, _threshold, _volatile] call FUNC(isDestructive) };
        if (_destructive >= 0) then {
            TRACE_1("boom", _destructive);
            [_this select 1] call CBA_fnc_removePerFrameHandler;
            [FUNC(destroyArea), [_pos, _removables], 0.2] call CBA_fnc_waitAndExecute;
        };
    };
}, 0, [_pos, _items, _threshold, _volatile]] call CBA_fnc_addPerFrameHandler;