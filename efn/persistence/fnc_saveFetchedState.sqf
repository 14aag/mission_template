#include "script_component.hpp"
params ["_name", "_hash"];

if (isNil "_hash") exitWith {
	["No state found for: %1", _name] call zen_common_fnc_showMessage;
};

private _states = profileNamespace getVariable [QGVAR(fetchedStates), createHashMap];
_states set [_name, _hash];
profileNamespace setVariable [QGVAR(fetchedStates), _states];
saveProfileNamespace;

["State %1 saved locally", _name] call zen_common_fnc_showMessage;
