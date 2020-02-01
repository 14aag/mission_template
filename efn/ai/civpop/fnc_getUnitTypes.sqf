#include "script_component.hpp"
params ["_type"];

private _units = [];
switch (_type) do {
    case "altis": {
        _units = ["C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F", "C_man_polo_6_F", "C_Man_casual_4_F", "C_Man_casual_5_F", "C_Man_casual_6_F", "C_Man_casual_1_F", "C_Man_casual_2_F", "C_Man_casual_3_F", "C_man_sport_1_F", "C_man_sport_2_F", "C_man_sport_3_F"];
    };
    case "workers": {
        _units = ["C_man_w_worker_F", "C_Man_UtilityWorker_01_F", "C_Man_ConstructionWorker_01_Black_F", "C_Man_ConstructionWorker_01_Red_F", "C_Man_ConstructionWorker_01_Blue_F"];
    };
    case "takistan": {
        _units = ["LOP_Tak_Civ_Random", "LOP_Tak_Civ_Man_01", "LOP_Tak_Civ_Man_02", "LOP_Tak_Civ_Man_04", "LOP_Tak_Civ_Man_05", "LOP_Tak_Civ_Man_06", "LOP_Tak_Civ_Man_07", "LOP_Tak_Civ_Man_08", "LOP_Tak_Civ_Man_09", "LOP_Tak_Civ_Man_10", "LOP_Tak_Civ_Man_11", "LOP_Tak_Civ_Man_12", "LOP_Tak_Civ_Man_13", "LOP_Tak_Civ_Man_14", "LOP_Tak_Civ_Man_15", "LOP_Tak_Civ_Man_16"];
    };
    default {};
};

_units