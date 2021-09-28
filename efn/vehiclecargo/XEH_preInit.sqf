#include "script_component.hpp"
#include "XEH_PREP.hpp"

if (isServer) then {
    [QGVAR(addCargo), FUNC(addCargo)] call CBA_fnc_addEventHandler;
    [QGVAR(loadCargo), FUNC(loadCargo)] call CBA_fnc_addEventHandler;
    [QGVAR(serverUnload), FUNC(serverUnload)] call CBA_fnc_addEventHandler;

    [QGVAR(handleDestroyed), FUNC(handleDestroyed)] call CBA_fnc_addEventHandler;
    ["All", "Deleted", FUNC(handleDeleted)] call CBA_fnc_addClassEventHandler;
};

["All", "Killed", {
    params ["_object"];
    if ((_object getVariable [QGVAR(loaded), []]) isNotEqualTo [] || !isNull (_object getVariable [QGVAR(storage), objNull])) then {
        [QGVAR(handleDestroyed), _this] call CBA_fnc_serverEvent;
    };
}] call CBA_fnc_addClassEventHandler;

[QGVAR(setHitPointDamages), {
    params ["_vehicle", "_applyTo", "_names", "_damages"];
    {
        private _index = _names find _x;
        if (_index >= 0) then {
            _vehicle setHitPointDamage [_x, _damages # _index, false];
        };
    } forEach _applyTo;
}] call CBA_fnc_addEventHandler;

if (!hasInterface) exitWith {};
[QGVAR(initVehicleActions), FUNC(initVehicleActions)] call CBA_fnc_addEventHandler;
[QGVAR(initCargo), FUNC(initCargo)] call CBA_fnc_addEventHandler;

private _mainAction = [QGVAR(mainAction), "Vehicle Storage"] call zen_context_menu_fnc_createAction;
private _addCargoAction = [QGVAR(addCargo), "Assign Storage", "",
                            {_objects call FUNC(zeusAddCargo)},
                            {_objects call FUNC(zeusCanAddCargo)}] call zen_context_menu_fnc_createAction;
[_mainAction] call zen_context_menu_fnc_addAction;
[_addCargoAction, [QGVAR(mainAction)], 0] call zen_context_menu_fnc_addAction;
