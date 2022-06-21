//Improved by bomb
//Added size tiers of vehicles
//Adds stringtable localization to automatically change language for players.

//Use base classes to cover more vehicles using less lines 
#define TINY_CAR "Motorcycle","ATV_Base_EP1"
#define SMALL_CAR "VWGolf","SkodaBase","Lada_base","Pickup_PK_base","hilux1_civil_1_open","Octavia_ACR_DZE","Volha_TK_CIV_Base_EP1","Offroad_DSHKM_base","Pickup_PK_base","S1203_TK_CIV_EP1","LandRover_Base","TowingTractor","JetSkiYanahui_Case_Blue","JetSkiYanahui_Case_Red","JetSkiYanahui_Case_Yellow","JetSkiYanahui_Case_Green","Smallboat_1_DZE","Smallboat_2_DZE","PBX_DZE","Zodiac_DZE"
#define MEDIUM_CAR "SUV_Base_EP1","ArmoredSUV_DZE_Base_PMC","UAZ_Base","BTR40_MG_base_EP1","BTR40_base_EP1","HMMWV_DZE_Base","HMMWV_Base","BAF_Jackal2_BASE_D","Fishing_Boat_DZE","RHIB_DZE","RHIB_DZ","RHIB2Turret_DZE","RHIB2Turret_DZ"
#define LARGE_CAR "Truck","Tractor","M113_Base","Wheeled_APC","Tracked_APC","Bus","Ikarus","epoch_car","Dingo_DZE_Base_ACR"	//"Tank"

#define TINY_AIR "CSJ_GyroC"
#define SMALL_AIR "MH6J_EP1","AH6J_EP1","AH6X_EP1","MTVR_Bird_base","pook_H13_base"
#define MEDIUM_AIR "BAF_Merlin_HC3_D","AW159_Lynx_BAF","UH1Y","UH1H_base","UH1_Base","Ka60_GL_BASE_PMC","MV22","MH60S_DZ","UH60M_EP1","UH60M_MEV_EP1"		//,"UH60_Base","MH60S" //messes with CH53
#define LARGE_AIR "Mi17_base","CH_47F_EP1","USEC_ch53_E"

LOG_CFG_ALLOW_LOCKED = false;	 	/* allow to transport locked vehicles */
LOG_CFG_ALLOW_CHAINING = false; 		/* allow chain towing  */
LOG_CFG_ALLOW_GETIN = false; 		/* allow player to get into a towed / lifted object  */

/////THE CONFIG OPTIONS BELOW MAY STILL HAVE ERRORS. PLEASE REPORT THEM TO ME IF YOU RUN INTO ANY ISSUES.../////

LOG_CFG_REQUIRED_MAGAZINE = ""; 		/* magazine CLASSNAME required for tow/chain , example: "equip_rope" */
LOG_CFG_CONSUME_MAGAZINE = true; 	/* consume magazine when tows vehicle */
LOG_CFG_RETURN_MAGAZINE = true; 	/* return magazine to player when vehicle is untowed (only if consume is true) */
LOG_CFG_REQUIRED_TOOL = ""; 			/* weapon/tool CLASSNAME required for tow/chain , example: "ItemToolbox" */
LOG_CFG_CONSUME_TOOL = false; 		/* consume item when tows vehicle */
LOG_CFG_RETURN_TOOL = false; 		/* return item to player when vehicle is untowed (only if consume is true) */
LOG_CFG_TOW_DISTANCE = 15; 			/* distance from vehicle to vehicle required to be towed. Recommended between 10 and 50... */
LOG_CFG_HIDE_SCROLL_OPTION = false; 	/* hides the option to tow a vehicle unless near a vehicle which can tow it. Distance is calculated using LOG_CFG_TOW_DISTANCE */

LOG_CFG_AIRTUG_TOW_DISTANCE = 25; 	/* distance from vehicle to vehicle required to be towed. Recommended between 10 and 50... */
LOG_CFG_HIDE_SCROLL_OPTION_AIRTUG = false; 	/* hides the option to tow a vehicle unless near a vehicle which can tow it. Distance is calculated using LOG_CFG_TOW_DISTANCE */

////END OF NEWLY ADDED (POSSIBLY BUGGY) CONFIG OPTIONS////

/*
	LIST OF VEHICLES WHERE CAN TOW
*/ 
//"Air", "AllVehicles", "All", "APC", "Bicycle", "Car", "Helicopter", "Land", "Motorcycle", "Plane", "Ship", "Tank"

LOG_CFG_CANTOW_TINY = [
TINY_CAR
];

LOG_CFG_CANTOW_SMALL = [
SMALL_CAR
];

LOG_CFG_CANTOW_MEDIUM = [
MEDIUM_CAR
];

LOG_CFG_CANTOW_LARGE = [
LARGE_CAR,"Tank","PaperCar"
];

LOG_CFG_CANTOW_AIRTUG = [
"TowingTractor","PaperCar","Tractor_Armored_DZE","TractorOld_DZE","Tractor_DZE"
];

/*
	LIST OF VEHICLES WHERE IS TOWABLE
*/ 

LOG_CFG_ISTOWABLE_TINY = [
TINY_CAR
];

LOG_CFG_ISTOWABLE_SMALL = LOG_CFG_ISTOWABLE_TINY + [
SMALL_CAR
];

LOG_CFG_ISTOWABLE_MEDIUM = LOG_CFG_ISTOWABLE_SMALL + [
MEDIUM_CAR
];

LOG_CFG_ISTOWABLE_LARGE = LOG_CFG_ISTOWABLE_MEDIUM + [
LARGE_CAR
];

LOG_CFG_ISTOWABLE_AIRTUG = [
"Plane"
];

/*
	LIST OF HELIS WHERE CAN LIFT
*/ 

LOG_CFG_CANLIFT_TINY = [
TINY_AIR
];

LOG_CFG_CANLIFT_SMALL = [
SMALL_AIR
];

LOG_CFG_CANLIFT_MEDIUM = [
MEDIUM_AIR
];

LOG_CFG_CANLIFT_LARGE = [
LARGE_AIR
];

/*
	LIST OF VEHICLES WHERE IS LIFTABLE
*/ 

LOG_CFG_ISLIFTABLE_TINY = [
TINY_CAR
];

LOG_CFG_ISLIFTABLE_SMALL = LOG_CFG_ISLIFTABLE_TINY + [
SMALL_CAR
];

LOG_CFG_ISLIFTABLE_MEDIUM = LOG_CFG_ISLIFTABLE_SMALL + [
MEDIUM_CAR
];

LOG_CFG_ISLIFTABLE_LARGE = LOG_CFG_ISLIFTABLE_MEDIUM + [
LARGE_CAR,"Tank",
TINY_AIR,
SMALL_AIR
];
