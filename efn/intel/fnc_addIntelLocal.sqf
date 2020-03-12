#include "script_component.hpp"
params ["_object", "_caller", "_var", "_marker"];

private _record = _object getVariable ["efn_intel_record", []];
private _recipients = _object getVariable "efn_intel_recipients";
private _texture = _object getVariable ["efn_intel_texture", ""];

_record params ["_title", "_text"];

private _text = format [
    "<font color='#99ffffff' face='PuristaLight'>" + localize "STR_A3_BIS_fnc_initIntelObject_found" + "</font><br />",
    format ["<marker name='%1'>%2</marker>",_marker,(markerpos _marker )call bis_fnc_locationDescription],
    name _caller
] + _text;
if (_texture != "") then {_text = _text + format ["<br /><img image='%1' height='200px' />",_texture];};

["intelAdded",[_title,_texture]] call bis_fnc_showNotification;

if !(player diarysubjectexists QFUNC(addIntelLocal)) then {player creatediarysubject [QFUNC(addIntelLocal),localize "STR_A3_BIS_fnc_initIntelObject_intel"];};
player creatediaryrecord [QFUNC(addIntelLocal),[_title,_text]];

private _action = _object getVariable ["efn_intel_action_id", -1];
if (_action >= 0) then {
    _object removeAction _action;
};

