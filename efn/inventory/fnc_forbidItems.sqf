#include "script_component.hpp"
params [["_items", [], [[]]]];
if (isServer) then {
    GVAR(forbiddenItems) insert [0, _items, true];
    publicVariable QGVAR(forbiddenItems);
};
