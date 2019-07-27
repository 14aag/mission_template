params ["_object", "_record", ["_recipients", 0], ["_texture", ""]];

#define SEARCH_ICON "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa"
[_object,
 "Search for Intel",
 SEARCH_ICON,
 SEARCH_ICON,
 '(_this distance _target < 3) && (!(_target isKindOf "Man") || (_this != _target && (captive _target || !(alive _target))))',
 "_caller distance _target < 3",
 {},
 {},
 {
     params ["_target", "_caller", "_actionId", "_arguments"];
     [_target, player] call efn_fnc_addIntel;
 },
 {},
 nil,
 5,
 20,
 true,
 false
] call BIS_fnc_holdActionAdd;

if (isServer) then {
    _object setVariable ["efn_intel_record", _record, true];
    _object setVariable ["efn_intel_recipients", _recipients, true];
    _object setVariable ["efn_intel_texture", _texture, true];
};

