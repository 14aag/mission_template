/*
    Killah Potatoes Cratefiller v1.1.0

    Author: Dubjunk - https://github.com/KillahPotatoes
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
    Configuration file for various variables of the KP cratefiller.
*/

// The Base object is for the player interaction, so at these object you can open the dialog
KPCF_cratefillerBase = [
    "Land_Cargo10_military_green_F"
];

// The Spawn object is the point where crates will spawn and acts the center for the KPCF_spawnRadius
KPCF_cratefillerSpawn = "PARACHUTE_TARGET";

// This variable defines if the player will be able to spawn and delete crates
KPCF_canSpawnAndDelete = true;

// If set to "true" the item lists will be generated from the config
KPCF_generateLists = true;

// These variable defines the range where inventories can be edited
// Example: With an setting of 10 all objects in a radius of 10m from the center of the spawn object can be edited
KPCF_spawnRadius = 10;

// Defines the distance for the interaction (addAction / ACE)
KPCF_interactRadius = 5;

// Defines the available crates
KPCF_crates = [
    	"ACE_medicalSupplyCrate_advanced",
	"aag14_logistics_ammo_v11",
	"aag14_logistics_launcher_v11",
	"aag14_logistics_ammo_v12",
	"aag14_logistics_launcher_v12",
	"aag14_logistics_ammo_v13",
	"aag14_logistics_launcher_v13",
	"aag14_logistics_ammo_loki",
	"aag14_logistics_launcher_loki",
	"aag14_logistics_explosives_hq",
	"aag14_logistics_weapons_hq",
	"aag14_logistics_special_soar",
	"aag14_logistics_special_v11",
	"aag14_logistics_special_v12",
	"aag14_logistics_special_v13",
	"aag14_logistics_special_loki",
	"B_supplyCrate_F",
    	"CargoNet_01_box_F",
	"Box_NATO_Ammo_F",
	"B_CargoNet_01_ammo_F"
];


// Defines the blacklisted items
// Blacklisted items are used on every category with activated generatedLists and everytime on the magazines and attachments
// So this variable will ensure the block of unwanted items
KPCF_blacklistedItems = [
    ""
];

// ----- This Variable will only be used with activated generatedLists -----

// Defines the whitelisted items
// Whitelisted items will be added after the item detection to ensure the availability
KPCF_whitelistedItems = ["KPCF", "whitelists"] call efn_inventory_fnc_loadInventoryFile;

KPCF_compatibleMagazineExtras = [["potato_vz99_carryWeapon", "potato_vz99_mortar60mm"]];
KPCF_grenadesExtras = ["MS_Strobe_Mag_1", "MS_Strobe_Mag_2"];

// ----- These Variables will be replaced with activated generatedLists -----

// Defines the available weapons
KPCF_weapons = [
    "arifle_SPAR_01_snd_F",
    "MMG_01_tan_F"
];

// Defines the available grenades
KPCF_grenades = [
    "HandGrenade",
    "MiniGrenade"
];

// Defines the available explosives
KPCF_explosives = [
    "DemoCharge_Remote_Mag",
    "ATMine_Range_Mag"
];

// Defines the available items
KPCF_items = [
    "FirstAidKit",
    "ToolKit"
];

// Defines the available backpacks
KPCF_backpacks = [
    "B_FieldPack_cbr",
    "B_AssaultPack_cbr"
];
