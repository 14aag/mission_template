// pretty much ripped from fparma
#include "script_component.hpp"
#define CAN_FIRE ((ACE_player getVariable [QGVAR(disableWeaponsReasons), []]) isEqualTo [])

params [["_disableWeapons", false], ["_reason", ""]];
if (!hasInterface) exitWith {};

if (isNil QGVAR(weaponsEventId)) then {
    GVAR(origAdvThrow) = missionNamespace getVariable ["ace_advanced_throwing_enabled", false];

    [{CAN_FIRE}] call ACE_explosives_fnc_addDetonateHandler;
    ["ace_firedPlayer", {
        if (CAN_FIRE) exitWith {};
        private _projectile = param [6, objNull];
        if (!isNil "ace_frag_fnc_addBlackList") then {
            [_projectile] call ace_frag_fnc_addBlacklist;
        };
        deleteVehicle _projectile;
    }] call CBA_fnc_addEventHandler;

    GVAR(weaponsEventId) = [ACE_player, "DefaultAction", {!CAN_FIRE}, {}] call ace_common_fnc_addActionEventHandler;
    ["unit", {
        params ["_new", "_old"];
        [_old, "DefaultAction", GVAR(weaponsEventId)] call ace_common_fnc_removeActionEventHandler;
        GVAR(weaponsEventId) = [_new, "DefaultAction", {!CAN_FIRE}, {}] call ace_common_fnc_addActionEventHandler;
    }] call CBA_fnc_addPlayerEventHandler;
};

_reason = toLower _reason;
private _reasons = ACE_player getVariable [QGVAR(disableWeaponsReasons), []];

if (_disableWeapons) then {
    _reasons pushBackUnique _reason;
    ace_advanced_throwing_enabled = false;
} else {
    _reasons deleteAt (_reasons find _reason);
    if (_reasons isEqualTo []) then {
        ace_advanced_throwing_enabled = GVAR(origAdvThrow);
    };
};

ACE_player setVariable [QGVAR(disableWeaponsReasons), _reasons];
