Shared-Plot-Poles v1.0<br>
Written by Rosska85

Installation
============

**STEP 1 (Copying Files)**

First, unpack your mission file.<br>
Now copy the "SharePlotPoles" folder to your mission directory.

**STEP 2 (Modifying fn_selfActions.sqf)**<br>
**A**<br>
Find

	isModularDoor = _typeOfCursorTarget in ["Land_DZE_WoodDoor","Land_DZE_LargeWoodDoor","Land_DZE_GarageWoodDoor","CinderWallDoor_DZ","CinderWallDoorSmall_DZ"];

AFTER that, add

	_nearplotPole = nearestObject [player,"Plastic_Pole_EP1_DZ"]; 
	_addedPUIDS = _cursorTarget getVariable ["AddedPUIDS", []];
	_hasBuildRights = if (_ownerID != "0") then {((getPlayerUID player) in (_addedPUIDS));}; //Check it's not a map object/unbuilt object to avoid RPT spam then check if player has rights
	_hasPlayerUID = player getVariable ["PUIDtoAdd", ""];

**B**<br>
Find

	if (_canDo && (speed player <= 1) && (_cursorTarget isKindOf "Plastic_Pole_EP1_DZ")) then {
		 if (s_player_maintain_area < 0) then {
		  	s_player_maintain_area = player addAction [format["<t color='#ff0000'>%1</t>",localize "STR_EPOCH_ACTIONS_MAINTAREA"], "\z\addons\dayz_code\actions\maintain_area.sqf", "maintain", 5, false];
		 	s_player_maintain_area_preview = player addAction [format["<t color='#ff0000'>%1</t>",localize "STR_EPOCH_ACTIONS_MAINTPREV"], "\z\addons\dayz_code\actions\maintain_area.sqf", "preview", 5, false];
		 };
	 } else {
    		player removeAction s_player_maintain_area;
    		s_player_maintain_area = -1;
    		player removeAction s_player_maintain_area_preview;
    		s_player_maintain_area_preview = -1;
	 };
	
REPLACE that with

	//Let players get other player's UID when near a plot pole
	if (_isMan && (_nearPlotPole distance player < 5)) Then {
		if (s_player_get_PUID < 0) then {
			s_player_get_PUID = player addAction [format["<t color='#ff8000'>Get Player UID to add rights on plot pole</t>"], "PUIDsOnPlotPoles\getPlayerUID.sqf", _cursorTarget, 5, false, true, "", ""];
		} else {
			player removeAction s_player_get_PUID;
			s_player_get_PUID = -1;
		};
	};
	 if (_canDo && (speed player <= 1) && (_cursorTarget isKindOf "Plastic_Pole_EP1_DZ")) then {
		 if (s_player_maintain_area < 0) then {
		  	s_player_maintain_area = player addAction [format["<t color='#ff0000'>%1</t>",localize "STR_EPOCH_ACTIONS_MAINTAREA"], "\z\addons\dayz_code\actions\maintain_area.sqf", "maintain", 5, false];
		 	s_player_maintain_area_preview = player addAction [format["<t color='#ff0000'>%1</t>",localize "STR_EPOCH_ACTIONS_MAINTPREV"], "\z\addons\dayz_code\actions\maintain_area.sqf", "preview", 5, false];
		 };
		if (_hasBuildRights || _ownerID == _playerUID) then {
			if (_hasPlayerUID != "") then {
				if (s_player_add_PUID < 0) then {
					s_player_add_PUID = player addAction [format["<t color='#ff8000'>Give player build rights</t>"], "PUIDsOnPlotPoles\addUIDtoPole.sqf", _cursorTarget, 5, false, true, "", ""];
				};
			};
			if (count _addedPUIDS > 0) then { //Only show remove option if there is someone to remove
				if (s_player_remove_PUID < 0) then {
					s_player_remove_PUID = player addAction ["<t color='#ff0000'>Remove a player's build rights</t>", "PUIDsOnPlotPoles\removeUIDfromPole.sqf", _cursorTarget, 5, false, true, "", ""];
				};
			};
		} else {
			player removeAction s_player_add_PUID;
			s_player_add_PUID = -1;
			player removeAction s_player_remove_PUID;
			s_player_remove_PUID = -1;
		};
	 } else {
    		player removeAction s_player_maintain_area;
    		s_player_maintain_area = -1;
    		player removeAction s_player_maintain_area_preview;
    		s_player_maintain_area_preview = -1;
	 };
	
**C**<br>
Find

	if(_isModular && (_playerUID == _ownerID)) then {
		 if(_hasToolbox && "ItemCrowbar" in _itemsPlayer) then {
			// diag_log text "fn_selfactions remove: [can remove modular item]";
				_player_deleteBuild = true;
		 };
	 };
	//Allow owners to delete modular doors without locks
	
	diag_log format["fn_actons: [PlayerUID: %1] [_ownerID: %2] [_isModularDoor: %3] [typeOfCursorTarget: %4]",_playerUID, _ownerID, _isModularDoor, _typeOfCursorTarget];
	
	if(_isModularDoor && (_playerUID == _ownerID)) then {
		if(_hasToolbox && "ItemCrowbar" in _itemsPlayer) then {
			_player_deleteBuild = true;
		 };		
	 };	
	 
REPLACE that, with

	//Allow owners and players with build rights to delete modulars
	_objectsPlotPole = nearestObjects [_cursorTarget, ["Plastic_Pole_EP1_DZ"], (DZE_PlotPole select 0)] select 0;
	_addedToBasePole = if (_isModular && (_playerUID in (_objectsPlotPole getVariable ["AddedPUIDS", []]))) then {true}else{false};
	if(_isModular && (_playerUID == _ownerID || _addedToBasePole)) then {
		if(_hasToolbox && "ItemCrowbar" in _itemsPlayer) then {
			// diag_log text "fn_selfactions remove: [can remove modular item]";
			_player_deleteBuild = true;
		};
	 };
	
	//Allow owners and players with the code to delete modular doors without locks
	if(_isModularDoor && (_playerUID == _ownerID || DZE_Lock_Door == _characterID)) then {
		if(_hasToolbox && "ItemCrowbar" in _itemsPlayer) then {
			_player_deleteBuild = true;
		 };		
	 };	
	 
**D**<br>
Find

	//Others
	player removeAction s_player_forceSave;
	s_player_forceSave = -1;
	
AFTER that, add

	player removeAction s_player_get_PUID;
	s_player_get_PUID = -1;
	player removeAction s_player_add_PUID;
	s_player_add_PUID = -1;
	player removeAction s_player_remove_PUID;
	s_player_remove_PUID = -1;
	
SAVE AND CLOSE

**STEP 3 (Modifying variables.sqf)**<br>
After
	
	//Player self-action handles
	dayz_resetSelfActions = {
	
Add

	s_player_get_PUID = -1;
	s_player_add_PUID = -1;
	s_player_remove_PUID = -1;
	
SAVE AND CLOSE

**STEP 4 (Modifying player_build.sqf AND player_upgrade.sqf)**<br>
BOTH OF THESE FILES NEED THE SAME EDIT, MAKE SURE YOU DO BOTH FILES!!!!

Find
	
	// check if friendly to owner
	if(_playerUID == _ownerID) then {

REPLACE it with

	//Check for other players added to the pole
	_addedPUIDS = _nearestPole getVariable ["AddedPUIDS", []];
	_hasBuildRights = ((getPlayerUID player) in (_addedPUIDS));
	// check if friendly to owner
	if(_playerUID == _ownerID || _hasBuildRights) then {

SAVE AND CLOSE

**STEP 5 (Modifying remove.sqf)**<br>
Find

	// check if friendly to owner
	if(_playerUID != _ownerID) then {
	
REPLACE it with

	//Check for other players added to the pole
	_addedPUIDS = _nearestPole getVariable ["AddedPUIDS", []];
	_hasBuildRights = ((getPlayerUID player) in (_addedPUIDS));
	// check if friendly to owner
	if(_playerUID != _ownerID || !(_hasBuildRights)) then {
	
**STEP 6 This one is in your dayz_server.pbo (Modifying server_monitor.sqf)**<br>
**A**<br>
Find
	
	_object setVariable ["lastUpdate",time];
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

**STEP 7 Again, this is in your dayz_server.pbo (Modifying server_updateObject.sqf)**<br>
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
		
