#include "script_component.hpp"
params ["_vehicle", "_item"];

private _itemSize = sizeOf typeOf _item;
private _emptyPosAGL = [
    _vehicle,
    MAX_LOAD_DISTANCE,
    MAX_LOAD_DISTANCE + _itemSize,
    _itemSize,
    0,
    0.35,
    0,
    [],
    [[0,0,0], [0,0,0]]
] call BIS_fnc_findSafePos;

TRACE_1("empty pos",_emptyPosAGL);

if (_emptyPosAGL isEqualTo [0,0,0]) exitWith {
    [localize "STR_ACE_common_NoRoomToUnload"] call ace_common_fnc_displayTextStructured;
    false
};

[QGVAR(serverUnload), [_vehicle, _item, _emptyPosAGL + [0]]] call CBA_fnc_serverEvent;
