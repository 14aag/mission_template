#include "script_component.hpp"
params ["_vehicle", "_item", "_posAGL"];

if !([_vehicle] call FUNC(isCargoLoaded)) exitWith {};

private _loaded = _vehicle getVariable [QGVAR(loaded), []];
if !(_item in _loaded) exitWith {};

_loaded set [_loaded find _item, objNull];
_vehicle setVariable [QGVAR(loaded), _loaded, true];

detach _item;
_item hideObjectGlobal false;
_item setPosASL (AGLToASL _posAGL);
[_item, "blockDamage", QUOTE(ADDON), false] call ace_common_fnc_statusEffect_set;

["ace_common_setFuel", [_item, _vehicle getVariable [QGVAR(cargoFuel), fuel _item]], [_item]] call CBA_fnc_targetEvent;
_item setDamage [_vehicle getVariable [QGVAR(cargoDamage), damage _item], false];
_vehicle getVariable [QGVAR(cargoHitPointsDamage), [[],[],[]]] params ["_names", "", "_damages"];
[
	QGVAR(setHitPointDamages),
	[_item, _vehicle getVariable [QGVAR(observedHitPointNames), []], _names, _damages],
	[_item]
] call CBA_fnc_targetEvent;

private _inventory = _vehicle getVariable [QGVAR(cargoInventory), []];
if !(_inventory isEqualTo []) then {
	[_item, _inventory] call EFUNC(persistence,setContainerInventory);
};
