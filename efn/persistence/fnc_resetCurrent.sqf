#include "script_component.hpp"

GVAR(persistence) call CBA_fnc_deleteNamespace;
GVAR(persistence) = false call CBA_fnc_createNamespace;
[] call FUNC(save);
