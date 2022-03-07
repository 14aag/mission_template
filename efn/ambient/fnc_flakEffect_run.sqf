#include "script_component.hpp"
params ["_logic", "_params"];
_params params ["_radius", "_heightVar"];

private _source = "#particlesource" createVehicleLocal [0, 0, 0];
private _pos = AGLToASL (_logic getPos [random _radius, random 360]);
_pos set [2, random [-_heightVar, 0, _heightVar] + (getPosASL _logic)#2];
_source setPosASL _pos;

private _smoke = "#particlesource" createVehicleLocal [0, 0, 0];
_smoke setPosASL _pos;
_smoke setParticleRandom [
    2,
    [0.4, 0.3, 0.4],
    [0.5, 0.5, 1],
    10,
    0.5,
    [0, 0, 0, 0],
    0,
    0,
    1
];
private _intensity = 1;
_smoke setParticleParams [
    ["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 0, 40, 1],
    "",
    "Billboard",
    1,
    2.5,
    [0, 0, 0],
    [0, 0, 0.5],
    0,
    0.053,
    0.04,
    0.2,
    [0.018 * _intensity + 1.2, 0.018 * _intensity + 3, 0.018 * _intensity + 5, 0.018 * _intensity + 7.5],
    [[1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 0.6], [1, 1, 1, 0.3], [1, 1, 1, 0]],
    [1.7, 0.6, 0.4, 0.3, 0.3],
    0.2,
    0.05,
    "",
    "",
    _source
];
_smoke setDropInterval 0.022;

private _fire = "#particlesource" createVehicleLocal [0, 0, 0];
_fire setPosASL _pos;
_fire setParticleRandom [
    0,
    [0, 0, 1],
    [0.2, 0.2, 0.5],
    1,
    0.5,
    [0, 0, 0, 0],
    0,
    0,
    1
];
_fire setParticleParams [
    ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 0, 32, 0],
    "",
    "Billboard",
    1,
    1,
    [0, 0, 0],
    [0, 0, 1],
    1,
    10,
    7.9,
    0.1,
    [0.0125 * _intensity + 1, 0.0125 * _intensity + 0.5],
    [[1, 1, 1, -1], [1, 1, 1, 0]],
    [2],
    0.2,
    0.2,
    "",
    "",
    _source
];
_fire setDropInterval 0.1;

private _light = "#lightpoint" createVehicleLocal [0, 0, 0];
_light setPosASL _pos;
_light setLightAttenuation [0, 0, 0, 2, 300, 600];
_light setLightBrightness 1;
_light setLightIntensity 80000;
_light setLightAmbient [0, 0, 0];
_light setLightColor [1, 0.68, 0.45];

[_pos, 1500, [], [], GVAR(flakSounds)] call FUNC(playEffectAudio);

[{
    params ["_light", "_startTime", "_duration", "_intensity"];
    private _runTime = CBA_missionTime - _startTime;
    _light setLightIntensity (_intensity * (1 - (_runTime / _duration)));
    _runTime >= _duration
}, {
    params ["_light"];
    deleteVehicle _light;
}, [_light, CBA_missionTime, 0.2, 80000]] call CBA_fnc_waitUntilAndExecute;
[{{deleteVehicle _x;} forEach _this;}, [_smoke, _fire, _source], 0.6] call CBA_fnc_waitAndExecute;

0.1 + random 0.2;
