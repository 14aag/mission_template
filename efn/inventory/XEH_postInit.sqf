#include "script_component.hpp"

["loadout", {
    [{
        params ["_unit", "_newUnitLoadout", "_oldUnitLoadout"];
        private _foundForbidden = (flatten _newUnitLoadout) arrayIntersect GVAR(forbiddenItems);
        if (_foundForbidden isNotEqualTo []) then {
            call FUNC(removeForbiddenItems);
        };
    }, _this] call CBA_fnc_execNextFrame;
}] call CBA_fnc_addPlayerEventHandler;

player addEventHandler ["InventoryClosed", {
    params ["_unit", "_container"];
    [{call FUNC(removeForbiddenItems);}, []] call CBA_fnc_execNextFrame;
}];
