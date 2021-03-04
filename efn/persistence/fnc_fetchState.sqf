#include "script_component.hpp"
params ["_unit", "_name"];

if (!isServer) exitWith {};

private _hash = profileNamespace getVariable format ["efn_save_%1", _name];
[_name, _hash] remoteExecCall [QFUNC(saveFetchedState), _unit];
