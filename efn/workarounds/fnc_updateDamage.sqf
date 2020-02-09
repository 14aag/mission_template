#include "script_component.hpp"
params ["_unit"];

if (!isPlayer _unit && {alive _unit}) then {
    [_unit, (_unit getHitPointDamage "HitHands") min 0.99] call ace_medical_engine_fnc_setStructuralDamage;
};

nil