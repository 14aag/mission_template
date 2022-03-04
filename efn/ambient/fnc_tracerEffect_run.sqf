#include "script_component.hpp"
if !(hasInterface) exitWith {};

params ["_source", "_params"];
_params params ["_color", "_directionRange", "_angleRange", "_velocityRange", "_size"];

private _count = _source getVariable [QGVAR(tracerBurstCount), 0];
if (_count <= 0) then {
    _count = 2 + floor (random 8);
};

private _dir = _source getVariable QGVAR(tracerBurstDirection);
if (isNil "_dir") then {
    _directionRange params ["_mid", "_var"];
    _dir = random [_mid - _var, _mid, _mid + _var];
    _source setVariable [QGVAR(tracerBurstDirection), _dir];
};

private _angle = _source getVariable QGVAR(tracerBurstAngle);
if (isNil "_angle") then {
    _angleRange params ["_mid", "_var"];
    _angle = random [_mid - _var, _mid, _mid + _var];
    _source setVariable [QGVAR(tracerBurstAngle), _angle];
};

private _velocity = _source getVariable QGVAR(tracerBurstVelocity);
if (isNil "_velocity") then {
    _velocityRange params ["_mid", "_var"];
    _velocity = random [_mid - _var, _mid, _mid + _var];
    _source setVariable [QGVAR(tracerBurstDirection), _dir];
};

private _bullet = "B_127x107_Ball" createVehicleLocal [0, 0, 0];
_bullet setPosASL getPosASL _source;
_bullet setVelocity [_velocity * cos _angle * sin _dir, _velocity * cos _angle * cos _dir, _velocity * sin _angle];

if (count GVAR(tracerSounds) > 0) then {
    private _sound = "#particlesource" createVehicleLocal [0, 0, 0];
    _sound setPosASL getPosASL _source;
    _sound say3D [selectRandom GVAR(tracerSounds), 1700];

    private _tail = "#particlesource" createVehicleLocal [0, 0, 0];
    _tail setPosASL getPosASL _source;
    _tail say3D [QGVAR(tracer_tail), 1700];

    [{ {deleteVehicle _x} forEach _this }, [_sound, _tail], 1] call CBA_fnc_waitAndExecute;
};

private _tracer = createSimpleObject [
    format ["A3\Weapons_f\Data\bullettracer\tracer_%1.p3d", _color],
    [0,0,0],
    true
];
_tracer attachTo [_bullet, [0,0,0]];
_tracer setPosASL getPosASL _bullet;

[{
    params ["_bullet", "_tracer", "_dir", "_size"];
    if (isNull _bullet) then {
        deleteVehicle _tracer;
        true
    } else {
        private _z = (vectorNormalized velocity _bullet) select 2;
        private _angle = -asin _z;
        _tracer setVectorDirAndUp [
            [sin (_dir - 180) * cos _angle, cos (_dir - 180) * cos _angle, sin _angle],
            [[0, sin _angle, -sin _angle], -_dir] call BIS_fnc_rotateVector2D
        ];
        _tracer setObjectScale _size;
        false
    }
}, {}, [_bullet, _tracer, _dir, _size]] call CBA_fnc_waitUntilAndExecute;

_count = _count - 1;
_source setVariable [QGVAR(tracerBurstCount), _count];
if (_count > 0) then {
    0.12 + random 0.04
} else {
    _source setVariable [QGVAR(tracerBurstDirection), nil];
    _source setVariable [QGVAR(tracerBurstAngle), nil];
    _source setVariable [QGVAR(tracerBurstVelocity), nil];

    1 + random 3
}
