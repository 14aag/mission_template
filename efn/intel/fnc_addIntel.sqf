params ["_object", "_caller"];

_var = ("efn_intel_script" + str _object) call bis_fnc_filterString;
_marker = createmarker [_var, position _object];
_caller playAction "putdown";

private _share = _object getVariable ["efn_intel_recipients", 0];
private _recipients = switch (_share) do {
    case 0: {side _caller};
    case 1: {group _caller};
    case 2: {_caller};
};

[_object, _caller, _var, _marker] remoteExec ["efn_fnc_addIntelLocal", _recipients, true];
