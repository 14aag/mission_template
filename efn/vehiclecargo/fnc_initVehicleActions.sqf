#include "script_component.hpp"
params ["_vehicle"];

if (isNil "_vehicle" || isNull _vehicle) exitWith {};
if (!hasInterface) exitWith {};
if (_vehicle getVariable [QGVAR(initVehicle), false]) exitWith {};
_vehicle setVariable [QGVAR(initVehicle), true];

private _vehicleAction = [
    QGVAR(unloadMenu), "Unload Vehicle", "",
    {},
    {
        params ["_target", "_player", "_params"];
        (_target getVariable [QGVAR(hasCargo), false]) &&
        {locked _target < 2} &&
        {([_player, _target] call ace_interaction_fnc_getInteractionDistance) < MAX_LOAD_DISTANCE} &&
        {alive _target} &&
        {[_player, _target, ["isNotSwimming"]] call ace_common_fnc_canInteractWith} &&
        {[_target] call FUNC(isCargoLoaded)}
    },
    {
        params ["_target", "_player", "_params"];
        private _actions = [];
        private _cargo = _target getVariable [QGVAR(loaded), []];

        {
            private _displayName = getText (configfile >> "CfgVehicles" >> typeOf _x >> "displayName");
            private _action = [
                format ["vehicle_%1", _forEachIndex], _displayName, "",
                {
                    params ["_target", "_player", "_params"];
                    [_target, _params] call FUNC(startUnloadCargo);
                },
                {true},
                {},
                _x
            ] call ace_interact_menu_fnc_createAction;
            _actions pushBack [_action, [], _target];
        } forEach _cargo;

        _actions
    }
] call ace_interact_menu_fnc_createAction;

[_vehicle, 0, ["ACE_MainActions"], _vehicleAction] call ace_interact_menu_fnc_addActionToObject;