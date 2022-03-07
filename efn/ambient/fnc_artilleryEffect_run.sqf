#include "script_component.hpp"
if !(hasInterface) exitWith {};

params ["_logic", "_params"];
_params params ["_range"];

private _fireIntensity = 10;
private _pos = AGLtoASL (_logic getPos [random _range, random 360]);
private _source = "#particlesource" createVehicleLocal [0, 0, 0];
_source setPosASL _pos;

private _fire = "#particlesource" createVehicleLocal [0, 0, 0];
_fire setPosASL _pos;
_fire setParticleRandom [
    0,
    [0.2, 0.2, 0.2],
    [0.2, 0.2, 0.5],
    25,
    0.2,
    [0, 0, 0, 0],
    0,
    0,
    1
];
_fire setParticleParams [
    ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 1, 20, 0],
    "",
    "Billboard",
    1,
    0.13,
    [0, 0, 0],
    [0, 0, 1],
    0,
    10,
    7.9,
    0.1,
    [0.0125 * _fireIntensity + 1, 0.0125 * _fireIntensity + 8, 0.0125 * _fireIntensity + 1],
    [[1, 1, 1, -8], [1, 1, 1, -1]],
    [1],
    0.2,
    0.2,
    "",
    "",
    _source
];

_fire setParticleCircle [0, [0, 0, 0]];
_fire setDropInterval 0.03;

private _smoke = "#particlesource" createVehicleLocal [0, 0, 0];
_smoke setPosASL AGLtoASL _pos;
_smoke setParticleRandom [
    3,
    [2, 2, 12],
    [1.5, 1.5, 5],
    10,
    0.5,
    [0, 0, 0, 0],
    0,
    0,
    1
];

_smoke setParticleParams [
    ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 7, 48, 1],
    "",
    "Billboard",
    1,
    8,
    [0, 0, 0],
    [0, 4, 0],
    0,
    1.275,
    1,
    0.25,
    [4,7,10,12],
    [[0.45,0.45,0.45,0.7], [0.5,0.5,0.5,0.5], [0.6,0.6,0.6,0.25], [0.65,0.65,0.65,0.01]],
    [0.5,0.3,0.25,0.2,0.18],
    0.2,
    0.05,
    "",
    "",
    _source
];

_smoke setParticleCircle [0, [0, 0, 0]];
_smoke setDropInterval 0.002;

private _light = "#lightpoint" createVehicleLocal [0, 0, 0];
_light setPosASL _pos;
_light setLightAttenuation [4, 0, 0, 0.2, 1000, 2000];
_light setLightBrightness 200;
_light setLightIntensity 100000;
_light setLightAmbient [0, 0, 0];
_light setLightColor [1, 0.6, 0.4];

[_pos, 3000, [], GVAR(mortarSoundsMid), GVAR(mortarSoundsDist), QGVAR(mortar_tail)] call FUNC(playEffectAudio);

[{
    params ["_light", "_startTime", "_duration", "_intensity"];
    private _runTime = CBA_missionTime - _startTime;
    _light setLightIntensity (_intensity * (1 - (_runTime / _duration)));
    _runTime >= _duration
}, {
    params ["_light", "", "", "", "_fire"];
    deleteVehicle _light;
    deleteVehicle _fire;
}, [_light, CBA_missionTime, 0.50, 100000, _fire]] call CBA_fnc_waitUntilAndExecute;

[{ deleteVehicle _this; }, _source, 1] call CBA_fnc_waitAndExecute;
[{ deleteVehicle _this; }, _smoke, 1] call CBA_fnc_waitAndExecute;

0.5 + random 3;
