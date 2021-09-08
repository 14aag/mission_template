#include "script_component.hpp"
params ["_unit"];

if !(_unit getVariable [QGVAR(monitorActive), false]) exitWith {};
private _lastChecked = _unit getVariable [QGVAR(lastFiredCheck), 0];
if (CBA_missionTime - _lastChecked < 0.5) exitWith {};
_unit setVariable [QGVAR(lastFiredCheck), CBA_missionTime];

[{
    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];

    if !(_unit getVariable [QGVAR(monitorActive), false]) exitWith {};
    private _shooter = _unit;
    if !(isNull _vehicle) then {
        _shooter = _vehicle;
    };

    private _spotters = [_shooter, 500] call FUNC(findPotentialSpotters);
    private _spotted = [_shooter, _spotters] call FUNC(findVisibleSpotter);
    if (_spotted >= 0) exitWith {
        [_unit, _spotters select _spotted] call FUNC(spotted);
    };

    private _ammoAudibleCoef = 1;
    private _muzzleAccessory = _unit weaponAccessories _weapon select 0;
    if (_weapon == _muzzle) then {
        private _muzzleSoundIndex = getNumber (configFile >> "CfgWeapons" >> _muzzleAccessory >> "ItemInfo" >> "soundTypeIndex");
        if (_muzzleSoundIndex != 0) then {
            _ammoAudibleCoef = 0.3;
        };
    };
    private _ammoAudible = getNumber (configFile >> "CfgAmmo" >> _ammo >> "audibleFire");

    _spotted = [_shooter, _spotters, _ammoAudible * _ammoAudibleCoef] call FUNC(findAudioSpotter);
    if (_spotted >= 0) then {
        [_unit, _spotters select _spotted] call FUNC(spotted);
    };

}, _this, 0.5] call CBA_fnc_waitAndExecute;
