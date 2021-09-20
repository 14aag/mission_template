#include "script_component.hpp"

private _hash = GVAR(currentState);
profileNamespace setVariable [GVAR(saveKey), _hash];
saveProfileNamespace;

GVAR(persistence) = +_hash;

diag_log text "[EFN] Mission saved";