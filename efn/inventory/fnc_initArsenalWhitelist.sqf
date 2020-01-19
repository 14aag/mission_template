#include "script_component.hpp"

params [["_box", objNull, [objNull]], ["_whitelistName", "", [""]]];

if (!isServer) exitWith {};
if (isNull _box) exitWith {};

private _whitelist = [_whitelistName, "whitelists"] call FUNC(loadInventoryFile);
if !(_whitelist isEqualType []) then { _whitelist = true; };

[_box, _whitelist] call ace_arsenal_fnc_initBox;

nil