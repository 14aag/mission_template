#include "script_component.hpp"
params [["_name", "", [""]]];

if (_name isEqualTo "") exitWith { objNull; };

private _whitelist = compile preprocessFileLineNumbers format ["whitelists\%1.txt", _name];
if (isNil "_whitelist") exitWith { objNull; };

call _whitelist;