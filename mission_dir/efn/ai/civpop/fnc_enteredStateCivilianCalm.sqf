#include "script_component.hpp"
params ["_agent"];

_agent forceWalk true;
_agent setVariable [QGVAR(panicTime), -1];
[_agent, ""] remoteExec ["switchMove", 0];
