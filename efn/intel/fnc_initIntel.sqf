params ["_object", "_record", ["_recipients", 0], ["_texture", ""]];

private _actionId = _object addAction [
	"Search for Intel",
        {[_this select 0, player] call efn_fnc_addIntel;},
        nil,
        1.5,
        true,
        true,
        "",
        '!(_originalTarget isKindOf "Man") || (_this != _originalTarget && (captive _originalTarget || !(alive _originalTarget)))',
        5
];

_object setVariable ["efn_intel_action_id", _actionId, false];

if (isServer) then {
    _object setVariable ["efn_intel_record", _record, true];
    _object setVariable ["efn_intel_recipients", _recipients, true];
    _object setVariable ["efn_intel_texture", _texture, true];
};

