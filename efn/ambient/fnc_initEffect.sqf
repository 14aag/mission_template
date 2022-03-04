#include "script_component.hpp"
params ["_logic", "_run", "_params"];
if !(isServer) exitWith {};
if (isNil QGVAR(logicGroup) || {isNull GVAR(logicGroup)}) then {
    GVAR(logicGroup) = createGroup sideLogic;
    GVAR(logicGroup) setGroupIdGlobal ["Ambient Effects"];
};
if (GVAR(logicGroup) != (group _logic)) then {
    [_logic] joinSilent GVAR(logicGroup);
};

_logic setVariable [QGVAR(params), _params, true];
_logic setVariable [QGVAR(run), compile format ["_this call %1;", _run], true];

GVAR(effects) pushBack _logic;
publicVariable QGVAR(effects);
