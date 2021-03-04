#include "script_component.hpp"

GVAR(currentState) call CBA_fnc_deleteNamespace;
GVAR(currentState) = false call CBA_fnc_createNamespace;
[] call FUNC(save);
