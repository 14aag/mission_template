private _hash = efn_persistence call CBA_fnc_serializeNamespace;
profileNamespace setVariable [efn_save_key, _hash];
saveProfileNamespace;

