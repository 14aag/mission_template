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
    case "african_christians": {
        _units = ["CFP_C_AFRCHRISTIAN_Civ_8_01", "CFP_C_AFRCHRISTIAN_Civ_2_01", "CFP_C_AFRCHRISTIAN_Civ_3_01", "CFP_C_AFRCHRISTIAN_Civ_4_01", "CFP_C_AFRCHRISTIAN_Civ_5_01", "CFP_C_AFRCHRISTIAN_Civ_6_01", "CFP_C_AFRCHRISTIAN_Civ_7_01", "CFP_C_AFRCHRISTIAN_Civ_1_01", "CFP_C_AFRCHRISTIAN_Civ_11_01", "CFP_C_AFRCHRISTIAN_Civ_12_01", "CFP_C_AFRCHRISTIAN_Civ_13_01", "CFP_C_AFRCHRISTIAN_Civ_14_01"];
    };
    case "african_islamic": {
        _units = ["CFP_C_AFRISLAMIC_Civ_7_01", "CFP_C_AFRISLAMIC_Civ_2_01", "CFP_C_AFRISLAMIC_Civ_3_01","CFP_C_AFRISLAMIC_Civ_4_01", "CFP_C_AFRISLAMIC_Civ_5_01", "CFP_C_AFRISLAMIC_Civ_6_01", "CFP_C_AFRISLAMIC_Civ_1_01", "CFP_C_AFRISLAMIC_Civ_8_01", "CFP_C_AFRISLAMIC_Civ_9_01", "CFP_C_AFRISLAMIC_Civ_10_01", "CFP_C_AFRISLAMIC_Civ_11_01", "CFP_C_AFRISLAMIC_Civ_12_01"];   
		};
    case "asian_city": {
        _units = ["CFP_C_ASIA_Civilian_7_01", "CFP_C_ASIA_Civilian_2_01", "CFP_C_ASIA_Civilian_3_01", "CFP_C_ASIA_Civilian_4_01", "CFP_C_ASIA_Civilian_5_01", "CFP_C_ASIA_Civilian_6_01", "CFP_C_ASIA_Civilian_8_01", "CFP_C_ASIA_Civilian_9_01", "CFP_C_ASIA_Civilian_10_01", "CFP_C_ASIA_Civilian_11_01", "CFP_C_ASIA_Civilian_12_01", "CFP_C_ASIA_Civilian_1_01"];   		
		};
    case "asian_rural": {
        _units = ["CPC_NAM_C_CIV_6", "CPC_NAM_C_CIV_8", "CPC_NAM_C_CIV_7", "CPC_NAM_C_CIV_9", "CPC_NAM_C_CIV_5", "CPC_NAM_C_CIV_3", "CPC_NAM_C_CIV_2", "CPC_NAM_C_CIV_4", "CPC_NAM_C_CIV_11", "CPC_NAM_C_CIV_13", "CPC_NAM_C_CIV_12", "CPC_NAM_C_CIV_14"];   
		};
    case "east_european": {
        _units = ["CUP_C_C_Assistant_01", "CUP_C_C_Citizen_02", "CUP_C_C_Citizen_01", "CUP_C_C_Citizen_04", "CUP_C_C_Citizen_03", "CUP_C_C_Worker_05", "CUP_C_C_Profiteer_02", "CUP_C_C_Profiteer_03", "CUP_C_C_Profiteer_04", "CUP_C_C_Racketeer_01", "CUP_C_C_Villager_01", "CUP_C_C_Villager_02", "CUP_C_C_Villager_03", "CUP_C_C_Woodlander_03", "CUP_C_C_Worker_04", "CUP_C_R_Worker_02", "CUP_C_R_Functionary_jacket_01", "CUP_C_R_Functionary_jacket_02", "CUP_C_R_Worker_01", "CUP_C_R_Racketeer_04", "CUP_C_R_Racketeer_02", "C_Man_1_enoch_F", "C_Man_6_enoch_F"];   
		};
    case "middle_eastern": {
        _units = ["CUP_C_TK_Man_04", "CUP_C_TK_Man_04_Jack", "CUP_C_TK_Man_04_Waist", "CUP_C_TK_Man_07", "CUP_C_TK_Man_07_Waist", "CUP_C_TK_Man_08_Jack", "CUP_C_TK_Man_05_Coat", "CUP_C_TK_Man_05_Waist", "CUP_C_TK_Man_06_Jack", "CUP_C_TK_Man_06_Coat", "CUP_C_TK_Man_02", "CUP_C_TK_Man_02_Jack", "CUP_C_TK_Man_01_Waist", "CUP_C_TK_Man_01_Jack", "CUP_C_TK_Man_03_Jack", "CUP_C_TK_Man_03_Waist", "CFP_C_AFG_Civilian_02", "CFP_C_AFG_Civilian_01", "CFP_C_ME_Civ_2_01", "CFP_C_ME_Civ_1_01"];   
		};
    case "idap": {
        _units = ["C_IDAP_Man_AidWorker_01_F", "C_IDAP_Man_AidWorker_07_F", "C_IDAP_Man_AidWorker_09_F", "C_IDAP_Man_AidWorker_08_F", "C_IDAP_Man_AidWorker_02_F", "C_IDAP_Man_AidWorker_05_F", "C_IDAP_Man_AidWorker_06_F", "C_IDAP_Man_AidWorker_03_F", "C_IDAP_Pilot_01_F", "C_IDAP_Man_Paramedic_01_F"];   
		};
    case "scientists": {
        _units = ["C_scientist_01_formal_F", "C_scientist_02_formal_F", "C_scientist_01_informal_F", "C_scientist_02_informal_F", "C_scientist_01_informal_F", "C_scientist_02_informal_F", "C_scientist_01_informal_F", "C_scientist_02_informal_F", "CUP_C_C_Doctor_01"];   
		};		
    default {};
};

_units
