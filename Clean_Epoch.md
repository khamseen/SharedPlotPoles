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

SAVE AND CLOSE<br><br>

YOU'RE DONE!!!! XD
		
