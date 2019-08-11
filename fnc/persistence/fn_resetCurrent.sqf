efn_persistence call CBA_fnc_deleteNamespace;
efn_persistence = false call CBA_fnc_createNamespace;
[] call efn_persistence_fnc_save;
