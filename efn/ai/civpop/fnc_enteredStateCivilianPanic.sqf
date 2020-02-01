#include "script_component.hpp"
params ["_agent"];

doStop _agent;
_agent forceWalk false;
_agent forceSpeed (_agent getSpeed "FAST");
_agent setVariable [QGVAR(panicTime), CBA_missionTime];

switch (round(random 2)) do {
    case 0: { [_agent, "ApanPercMstpSnonWnonDnon_G01"] remoteExec ["switchMove", 0] };
    case 2: { _agent playMoveNow "ApanPpneMstpSnonWnonDnon_G01" };
    default { _agent playMoveNow "ApanPknlMstpSnonWnonDnon_G01" };
};

_agent setVariable [QGVAR(nextMove), CBA_missionTime];