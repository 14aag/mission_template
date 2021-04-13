#include "script_component.hpp"

private _dropContainerAction = [
    QGVAR(placeContainer),
    "Place Ammo Container",
    "",
    {_this call FUNC(dropContainer)},
    {_this call FUNC(canDropContainer)}
] call ace_interact_menu_fnc_createAction;

["CAManBase", 1, ["ACE_SelfActions"], _dropContainerAction, true] call ace_interact_menu_fnc_addActionToClass;

[QGVAR(initSupplyVehicle), { 
    [_this] call FUNC(initSupplyVehicle);
}] call CBA_fnc_addEventHandler;
