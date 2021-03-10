#include "script_component.hpp"

if (!isNull GVAR(tent)) then {
    deleteVehicle GVAR(tent);
};

private _actionId = player getVariable QGVAR(placeAction);
if (!isNil "_actionId") then {
    player setVariable [QGVAR(placeAction), nil];
    [player, "DefaultAction", _actionId] call ace_common_fnc_removeActionEventHandler;
};
[] call ace_interaction_fnc_hideMouseHint;

[player, "forceWalk", QUOTE(ADDON), false] call ace_common_fnc_statusEffect_set;
[player, "blockThrow", QUOTE(ADDON), false] call ace_common_fnc_statusEffect_set;
