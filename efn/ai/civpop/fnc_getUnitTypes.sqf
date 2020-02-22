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
    case "easteurope": {
        _units = ["UK3CB_CHC_C_ACT", "UK3CB_CHC_C_BODYG", "UK3CB_CHC_C_CIT", "UK3CB_CHC_C_COACH", "UK3CB_CHC_C_DOC", "UK3CB_CHC_C_FUNC", "UK3CB_CHC_C_HIKER", "UK3CB_CHC_C_LABOUR", "UK3CB_CHC_C_PILOT", "UK3CB_CHC_C_POLITIC", "UK3CB_CHC_C_PRIEST", "UK3CB_CHC_C_PROF", "UK3CB_CHC_C_CIV", "UK3CB_CHC_C_SPY", "UK3CB_CHC_C_VILL", "UK3CB_CHC_C_CAN", "UK3CB_CHC_C_WOOD", "UK3CB_CHC_C_WORKER", "LOP_CHR_Civ_Assistant", "LOP_CHR_Civ_Citizen_03", "LOP_CHR_Civ_Citizen_04", "LOP_CHR_Civ_Citizen_01", "LOP_CHR_Civ_Citizen_02", "LOP_CHR_Civ_Doctor_01", "LOP_CHR_Civ_Functionary_01", "LOP_CHR_Civ_Functionary_02", "LOP_CHR_Civ_Priest_01", "LOP_CHR_Civ_Policeman_01", "LOP_CHR_Civ_Profiteer_02", "LOP_CHR_Civ_Profiteer_03", "LOP_CHR_Civ_Profiteer_01", "LOP_CHR_Civ_Profiteer_04", "LOP_CHR_Civ_Random", "LOP_CHR_Civ_Rocker_03", "LOP_CHR_Civ_Rocker_01", "LOP_CHR_Civ_Rocker_04", "LOP_CHR_Civ_Rocker_02", "LOP_CHR_Civ_SchoolTeacher", "LOP_CHR_Civ_Villager_01", "LOP_CHR_Civ_Villager_04", "LOP_CHR_Civ_Villager_03", "LOP_CHR_Civ_Villager_02", "LOP_CHR_Civ_Woodlander_01", "LOP_CHR_Civ_Woodlander_02", "LOP_CHR_Civ_Woodlander_03", "LOP_CHR_Civ_Woodlander_04", "LOP_CHR_Civ_Worker_03", "LOP_CHR_Civ_Worker_04", "LOP_CHR_Civ_Worker_01", "LOP_CHR_Civ_Worker_02"];
    };
    default {};
};

_units