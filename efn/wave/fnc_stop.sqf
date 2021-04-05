#include "script_component.hpp"
params ["_waveConfiguration"];

if (_waveConfiguration isEqualType "") then {
    _waveConfiguration = GVAR(waveConfigurations) get _waveConfiguration;
};

private _index = GVAR(active) find _waveConfiguration;
if (_index >= 0) then {
    private _configuration = GVAR(active) select _index;
    GVAR(active) set [_index, objNull];

    _configuration setVariable [QGVAR(lastSpawnTime), -1e10];
    _configuration setVariable [QGVAR(currentIndex), -1];
    _configuration setVariable [QGVAR(currentWave), []];
};
