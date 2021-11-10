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
    ([player] + _chestpack) call bocr_main_fnc_addChestpack;
};

if (_earplugs) then {
    player addItemToUniform "ACE_Earplugs";
    [player] call ace_hearing_fnc_putInEarplugs;
};

nil
