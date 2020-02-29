#include "script_component.hpp"

private _hash = GVAR(persistence) call CBA_fnc_serializeNamespace;
profileNamespace setVariable [GVAR(saveKey), _hash];
saveProfileNamespace;

diag_log text "[EFN] Mission saved";