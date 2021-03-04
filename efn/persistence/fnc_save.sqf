#include "script_component.hpp"

private _hash = GVAR(currentState) call CBA_fnc_serializeNamespace;
profileNamespace setVariable [GVAR(saveKey), _hash];
saveProfileNamespace;

GVAR(persistence) call CBA_fnc_deleteNamespace;
GVAR(persistence) = [_hash] call CBA_fnc_deserializeNamespace;

diag_log text "[EFN] Mission saved";