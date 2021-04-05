#include "script_component.hpp"

{
    if (isNull _x) then { continue; };

    private _list = _x getVariable [QGVAR(list), []];
    if (_list isEqualTo []) then { continue; };

    private _condition = _x getVariable [QGVAR(condition), {true}];
    private _minLifetime = _x getVariable [QGVAR(minLifetime), 0];
    private _looping = _x getVariable [QGVAR(looping), false];
    
    private _lastSpawn = _x getVariable [QGVAR(lastSpawnTime), -1e10];
    private _currentIndex = _x getVariable [QGVAR(currentIndex), -1];
    private _currentWave = _x getVariable [QGVAR(currentWave), []];
    private _strength = _x getVariable [QGVAR(waveStrength), 0];
    private _alive = 0;
    private _duration = CBA_missionTime - _lastSpawn;
    {_alive = _alive + ({alive _x} count units _x)} forEach _currentWave;
    if (_duration > _minLifetime && {_alive == 0 || {call _condition}}) then {
        _currentIndex = _currentIndex + 1;
        if (_currentIndex >= count _list) then {
            if (!_looping) then {
                [_x] call FUNC(stop);
                continue;
            };
            _currentIndex = 0;
        };

        private _nextWave = _list select _currentIndex;
        private _spawned = [_nextWave] call FUNC(spawnWave);
        _currentWave append _spawned;

        _strength = 0;
        {_strength = _strength + count units _x} forEach _spawned;
        _x setVariable [QGVAR(currentWave), _currentWave];
        _x setVariable [QGVAR(lastSpawnTime), CBA_missionTime];
        _x setVariable [QGVAR(currentIndex), _currentIndex];
        _x setVariable [QGVAR(waveStrength), _strength];
    };
} forEach GVAR(active);
