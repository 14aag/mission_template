#include "script_component.hpp"
params ["_vehicle", "_item"];
TRACE_2("load cargo",_vehicle,_item);

private _assigned = _vehicle getVariable [QGVAR(assignedCargo), []];
private _index = _assigned find _item;
if (_index < 0) exitWith {};

private _loaded = _vehicle getVariable [QGVAR(loaded), []];
if (_item in _loaded) exitWith {};

_loaded set [_index, _item];
_vehicle setVariable [QGVAR(loaded), _loaded, true];

detach _item;
_item attachTo [_vehicle, [0, 0, -100]];
["ace_common_hideObjectGlobal", [_item, true]] call CBA_fnc_serverEvent;
[_item, "blockDamage", QUOTE(ADDON), true] call ace_common_fnc_statusEffect_set;

_vehicle setVariable [QGVAR(cargoDamage), damage _item, true];
_vehicle setVariable [QGVAR(cargoFuel), fuel _item, true];
_vehicle setVariable [QGVAR(cargoHitPointsDamage), getAllHitPointsDamage _item, true];
_vehicle setVariable [QGVAR(cargoInventory), [_item] call EFUNC(persistence,getInventory), true];
