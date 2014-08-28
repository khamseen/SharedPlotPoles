/* CUSTOM COMPILES AND OVERRIDES */
//Only do this on clients
if (!isDedicated) then {
	admin_list_thingy			= compile preprocessFileLineNumbers "admintools\AdminList.sqf";
	fnc_usec_selfActions 			= compile preprocessFileLineNumbers "dayz_code\actions\fn_selfActions.sqf"; //User actions
	player_build					= compile preprocessFileLineNumbers "dayz_code\actions\player_build.sqf";
	player_removeObject 			= compile preprocessFileLineNumbers "dayz_code\actions\remove.sqf";
};