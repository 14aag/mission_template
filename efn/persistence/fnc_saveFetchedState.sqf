#include "script_component.hpp"
params ["_name", "_hash"];

if (isNil "_hash") exitWith {
	["No state found for: %1", _name] call zen_common_fnc_showMessage;
};

private _states = profileNamespace getVariable ["efn_fetched_states", createHashMap];
_states set [_name, _hash];
profileNamespace setVariable ["efn_fetched_states", _states];
saveProfileNamespace;

["State %1 saved locally", _name] call zen_common_fnc_showMessage;
