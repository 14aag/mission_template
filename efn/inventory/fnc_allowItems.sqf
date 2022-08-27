#include "script_component.hpp"
params [["_items", [], [[]]]];
if (isServer) then {
    GVAR(forbiddenItems) = GVAR(forbiddenItems) - _items;
    publicVariable QGVAR(forbiddenItems);
};
