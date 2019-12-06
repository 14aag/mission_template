params ["_box", "_name", "_loadout"];

private _load = {
    params ["_target", "_caller", "_actionId", "_arguments"];

    _caller setUnitLoadout _arguments;
};

_box addAction [format ["Take %1 loadout", _name], _load, _loadout, 1.5, false, true, "", "true", 5];
