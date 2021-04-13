#include "script_component.hpp"
params ["_unit"];
   
(alive _unit)
&& {(_unit getVariable [QGVAR(hasContainer), false])}
&& {[_unit, objNull, ["IsNotInside"]] call ace_common_fnc_canInteractWith} // manually added actions need this
