#include "script_component.hpp"

private _hash = profileNamespace getVariable [QGVAR(fetchedStates), createHashMap];
private _saves = (keys _hash) select {_x find worldName == ((count _x - count worldName) max 0)};

if (count _saves == 0) exitWith {
    ["No saved states found"] call zen_common_fnc_showMessage;
};

[
    "Choose existing save state",
    [
        ["COMBO", "Save", [_saves, _saves apply { _x select [0, count _x - count worldName - 1]}], true]
    ],
    {
        params ["_dialogValues", "_hash"];
        _dialogValues params ["_selectedState"];
        [_hash get _selectedState] remoteExecCall [QFUNC(loadState), 2];
    },
    {},
    _hash
] call zen_dialog_fnc_create;
