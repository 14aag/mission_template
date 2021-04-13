#include "script_component.hpp"
/*
 * Author: GitHawk
 * Modified from ACE by Eclipser
 * Show the resupplyable ammunition of all surrounding vehicles.
 *
 * Arguments:
 * 0: Ammo Truck <OBJECT>
 * 1: Player <OBJECT>
 *
 * Return Value:
 * ChildActions <ARRAY>
 *
 * Example:
 * [tank, player] call efn_rearm_fnc_addRearmActions
 *
 * Public: No
 */

params ["_truck", "_player"];

private _vehicles = nearestObjects [_truck, ["AllVehicles"], ace_rearm_distance];
_vehicles = _vehicles select {(_x != _truck) && {!(_x isKindOf "CAManBase")} && {!(_x getVariable ["ace_rearm_disabled", false])}};

private _cswCarryMagazines = [];
private _vehicleActions = [];
{
    private _vehicle = _x;

    // Array of magazines that can be rearmed in the vehicle
    private _needRearmMags = ([_vehicle] call ace_rearm_fnc_getNeedRearmMagazines) apply {_x select 0};

    // _needRearmMags without duplicates
    private _magazineHelper = _needRearmMags arrayIntersect _needRearmMags;

    _magazineHelper = _magazineHelper select {[_truck, _x] call FUNC(hasEnoughSupply)};

    if (["ace_csw"] call ace_common_fnc_isModLoaded) then {
        ([_vehicle] call ace_csw_fnc_aceRearmGetCarryMagazines) params ["_turretMagsCSW", "_allCarryMags"];
        TRACE_3("csw compat",_vehicle,_turretMagsCSW,_allCarryMags);
        _cswCarryMagazines append _allCarryMags;
        _magazineHelper = _magazineHelper - _turretMagsCSW;
    };

    TRACE_2("can add",_x,_magazineHelper);

    if (_magazineHelper isNotEqualTo []) then {
        private _icon = getText(configOf _vehicle >> "Icon");
        if !((_icon select [0, 1]) == "\") then {
            _icon = "";
        };
        private _actions = [];
        {
            private _action = [
                _x,
                _x call ace_rearm_fnc_getMagazineName,
                getText(configFile >> "CfgMagazines" >> _x >> "picture"),
                {_this call FUNC(takeAmmo)},
                {true},
                {},
                [_x, _vehicle]
            ] call ace_interact_menu_fnc_createAction;

            _actions pushBack [_action, [], _truck];
        } forEach _magazineHelper;

        private _action = [
            _vehicle,
            getText(configOf _vehicle >> "displayName"),
            _icon,
            {},
            {true},
            {},
            []
        ] call ace_interact_menu_fnc_createAction;

        _vehicleActions pushBack [_action, _actions, _truck];
    };
} forEach _vehicles;

if (_cswCarryMagazines isNotEqualTo []) then {
    _cswCarryMagazines = _cswCarryMagazines arrayIntersect _cswCarryMagazines;
    _cswCarryMagazines = _cswCarryMagazines select {[_truck, _x] call FUNC(hasEnoughSupply)};
    private _baseAction = ["ace_rearm_cswTake", "CSW", "", {}, {true}] call ace_interact_menu_fnc_createAction;
    private _subActions = _cswCarryMagazines apply {
        private _action = [
            _x,
            _x call ace_rearm_fnc_getMagazineName,
            getText(configFile >> "CfgMagazines" >> _x >> "picture"),
            {_this call FUNC(takeAmmo)},
            {true},
            {},
            [_x, _player]
        ] call ace_interact_menu_fnc_createAction;
        [_action, [], _truck];
    };
    _vehicleActions pushBack [_baseAction, _subActions, _truck];
};

_vehicleActions
