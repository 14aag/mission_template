params ["_unit", "_pos"];

private _tent = [_unit, true] call efn_respawn_fnc_getTent;
if !(_tent isEqualTo objNull) then {
    _tent setVariable ["efn_respawn_tickets", efn_respawn_ticketCount];
    _tent setPos _pos;
};

nil