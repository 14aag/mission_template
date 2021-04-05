#include "script_component.hpp"
params ["_name"];

private _waveConfiguration = GVAR(waveConfigurations) get _name;
if (isNil "_waveConfiguration") exitWith {
    ERROR_1("wave configuration not found", _name);
};

GVAR(active) pushBackUnique _waveConfiguration;
if (GVAR(pfhId) == -1) then {
    [FUNC(wavePfh), 5] call CBA_fnc_addPerFrameHandler;
};
