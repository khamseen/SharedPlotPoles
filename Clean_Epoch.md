Shared-Plot-Poles v1.0<br>
Written by Rosska85

Installation
============

**STEP 1 (Copying Files)**

First, unpack your mission file.<br>
Now copy the "SharePlotPoles" and "dayz_code" folders to your mission directory.<br>

**STEP 2 (Modifying init.sqf)**<br>
**A**<br>
Find
	
	call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\variables.sqf";				//Initilize the Variables (IMPORTANT: Must happen very early)
	
After that, add

	call compile preprocessFileLineNumbers "dayz_code\init\variables.sqf";				//Custom Variables and overrides
	
**B**<br>
Find
	
	call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\compiles.sqf";				//Compile regular functions
	
After that, add
	
	call compile preprocessFileLineNumbers "dayz_code\init\compiles.sqf";						//Compile custom functions and overrides

SAVE AND CLOSE<br>

**STEP 3 This one is in your dayz_server.pbo (Modifying server_monitor.sqf)**<br>
**A**<br>
Find
	
	_object setVariable ["ObjectID", _idKey, true];

AFTER that, add

	if (typeOf (_object) == "Plastic_Pole_EP1_DZ") then {
		_object setVariable ["AddedPUIDS", _intentory, true];
	};
	
**B**<br>
Find

	if (count _intentory > 0) then {

REPLACE that with
	
	if ((count _intentory > 0) && !(typeOf( _object) == "Plastic_Pole_EP1_DZ")) then {
	
SAVE AND CLOSE

**STEP 4 Again, this is in your dayz_server.pbo (Modifying server_updateObject.sqf)**<br>
Find

	_inventory = [
		getWeaponCargo _object,
		getMagazineCargo _object,
		getBackpackCargo _object
	];
		
REPLACE that with

	if (typeOf (_object) == "Plastic_Pole_EP1_DZ") then{
		_inventory = _object getVariable ["AddedPUIDS", []]; //We're replacing the inventory with UIDs for this item
	} else {
		_inventory = [
			getWeaponCargo _object,
			getMagazineCargo _object,
			getBackpackCargo _object
		];
	};
	
SAVE AND CLOSE<br><br>

YOU'RE DONE!!!! XD
		
