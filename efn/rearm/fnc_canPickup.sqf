#include "script_component.hpp"
params ["_truck", "_unit"];
   
(alive _unit)
&& {!(_unit getVariable [QGVAR(hasContainer), false])}
&& {alive _truck}
&& {(_truck distance _unit) < REARM_ACTION_DISTANCE}
&& {[_unit, _truck, ["IsNotInside"]] call ace_common_fnc_canInteractWith} // manually added actions need this
