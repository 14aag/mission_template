#include "script_component.hpp"
params ["_unit"];

_unit setVariable [QGVAR(AFMrequired), true];

if (hasInterface) then {
    ["CBA_loadingScreenDone", {
        if !(player getVariable [QGVAR(AFMrequired), false]) exitWith {};
        [player, "GetInMan", {
            params ["_unit", "", "_vehicle"];
            if (_vehicle isKindOf "Helicopter" && {GVAR(requireAFMmode) == 1 && {!difficultyEnabledRTD}}) then {
                systemChat "AFM not enabled";
                [QGVAR(afmShame), [_unit]] call CBA_fnc_remoteEvent;
            };
        }] call CBA_fnc_addBISEventHandler;

        [QGVAR(afmShame), {
            params ["_unit"];
            if (GVAR(requireAFMmode) == 1) then {
                systemChat format ["%1 has AFM disabled.", name _unit];
            };
        }] call CBA_fnc_addEventHandler;
    }] call CBA_fnc_addEventHandlerArgs;
};
