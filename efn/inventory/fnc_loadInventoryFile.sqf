#include "script_component.hpp"
params [["_name", "", [""]], ["_type", "", [""]]];

if (_name isEqualTo "") exitWith { objNull; };
if (_type isEqualTo "") exitWith { objNull; };

private _contents = compile preprocessFileLineNumbers format ["%1\%2.txt", _type, _name];
if (isNil "_contents") exitWith { objNull; };

call _contents;