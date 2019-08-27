#include "script_component.hpp"

params ["_loadout", "_pos", ["_chestpack", []], ["_earplugs", false]];

if (_loadout isEqualType []) then {
    player setUnitLoadout _loadout;
};

if (_pos isEqualType []) then {
    player setDir (_pos select 0);
    player setPosASL (_pos select 1);
};

if !(_chestpack isEqualTo []) then {
    [player, _chestpack select 0] call zade_boc_fnc_addChestpack;
    private _var = player getVariable ["zade_boc_chestpack", nil];
    if !(isNil "_var") then {
        _var set [2, _chestpack select 1];
        _var set [3, _chestpack select 2];
    };
    player setVariable ["zade_boc_chestpack", _var, true];
};

if (_earplugs) then {
    player addItemToUniform "ACE_Earplugs";
    [player] call ace_hearing_fnc_putInEarplugs;
};

nil
