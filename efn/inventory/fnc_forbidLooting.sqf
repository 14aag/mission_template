#include "script_component.hpp"
params ["_enabled"];

GVAR(lootingForbidden) = _enabled;
player setVariable [QGVAR(lootingForbidden), _enabled, true];

if (_enabled) then {
    systemChat "Looting forbidden";
    [{
        params ["", "_id"];
        ctrlShow [632, !GVAR(lootingForbidden)]; // hide container
        ctrlShow [640, !GVAR(lootingForbidden)]; // hide ground

        if (!GVAR(lootingForbidden)) then {
            inGameUISetEventHandler ["Action", ""];
            [_id] call CBA_fnc_removePerFrameHandler;
        } else {
            if (vehicle player == player) then {
                inGameUISetEventHandler ["Action", QUOTE(GVAR(lootingForbidden) && {(_this#3) in [ARR_3('TakeWeapon','Rearm','TakeItem')]})];
            };
        };
    }] call CBA_fnc_addPerFrameHandler;

    if (GVAR(hasAIME)) then {
        GVAR(currentAIMEHolderSetting) = UPSL_AIME_inventory_setting_holder_action;
        UPSL_AIME_inventory_setting_holder_action = false;

        GVAR(settingsHandler) = ["CBA_SettingChanged", {
            params ["_setting", "_value"];
            if (_setting == "UPSL_AIME_inventory_setting_holder_action") then {
                GVAR(currentAIMEHolderSetting) = _value;
                UPSL_AIME_inventory_setting_holder_action = false;
            }
        }] call CBA_fnc_addEventHandler;
    };
} else {
    systemChat "Looting allowed";

    if (GVAR(hasAIME) && {!isNil QGVAR(settingsHandler)} && {GVAR(settingsHandler) >= 0}) then {
        UPSL_AIME_inventory_setting_holder_action = GVAR(currentAIMEHolderSetting);
        ["CBA_SettingChanged", GVAR(settingsHandler)] call CBA_fnc_removeEventHandler;
    };
};
