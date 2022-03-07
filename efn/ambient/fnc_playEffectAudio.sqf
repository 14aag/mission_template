#include "script_component.hpp"
params ["", "", "_near", "_mid", "_dist", ""];

if (count _near > 0 || {count _mid > 0} || {count _dist > 0}) then {
    [{
        params ["_impactTime", "_pos", "_maxDistance", "_nearSounds", "_midSounds", "_distSounds", ["_tailSound", "", [""]]];
        private _soundTravelTime = CBA_missionTime - _impactTime;

        private _playerView = if (isNull curatorCamera) then { ACE_player } else { curatorCamera };

        if ((_soundTravelTime * 343) >= (_pos distance _playerView)) then {
            private _soundSources = [];
            if (count _distSounds > 0) then {
                private _dist = "#particlesource" createVehicleLocal [0, 0, 0];
                _dist setPosASL _pos;
                _dist say3D [selectRandom _distSounds, _maxDistance];
                _soundSources pushBack _dist;
            };

            if (count _midSounds > 0) then {
                private _mid = "#particlesource" createVehicleLocal [0, 0, 0];
                _mid setPosASL _pos;
                _mid say3D [selectRandom _midSounds, _maxDistance * 0.12];
                _soundSources pushBack _mid;
            };

            if (count _nearSounds > 0) then {
                private _near = "#particlesource" createVehicleLocal [0, 0, 0];
                _near setPosASL _pos;
                _near say3D [selectRandom _nearSounds, _maxDistance * 0.03];
                _soundSources pushBack _near;
            };

            if (_tailSound isNotEqualTo "") then {
                private _tail = "#particlesource" createVehicleLocal [0, 0, 0];
                _tail setPosASL _pos;
                [{
                    params ["_tail", "_tailSound", "_maxDistance"];
                    _tail say3D [_tailSound, _maxDistance];
                }, [_tail, _tailSound, _maxDistance], 0.1] call CBA_fnc_waitAndExecute;
                _soundSources pushBack _tail;
            };
            [{ {deleteVehicle _x} forEach _this }, _soundSources, 5] call CBA_fnc_waitAndExecute;
            true
        } else {
            _soundTravelTime > (ceil (_maxDistance / 343));
        }
    }, {}, [CBA_missionTime] + _this] call CBA_fnc_waitUntilAndExecute;
};
