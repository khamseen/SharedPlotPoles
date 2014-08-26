private ["_plotPole","_addedPUIDS"];

_plotPole = _this select 3;
_addedPUIDS = _plotPole getVariable ["AddedPUIDS", []];

//Get list of Player UIDs from the pole
addedUIDList = [];
for "_i" from 0 to (count _addedPUIDS) -1 do {
	addedUIDList set [(count addedUIDList), _addedPUIDS select _i];
};

//Set variables
removeUIDSelect = "";
exitscript = true;
snext = false;

//Create the menu of UIDs
removeUIDMenu =
{
	private ["_removeMenu","_removeArray"];
	_removeMenu = [["",true], ["Select the UID to remove:", [-1], "", -5, [["expression", ""]], "1", "0"]];
	for "_i" from (_this select 0) to (_this select 1) do
	{
		_removeArray = [format['%1', addedUIDList select (_i)], [_i - (_this select 0) + 2], "", -5, [["expression", format ["removeUIDSelect = addedUIDList select %1", _i]]], "1", "1"];
		_removeMenu set [_i + 2, _removeArray];
	};
	_removeMenu set [(_this select 1) + 2, ["", [-1], "", -5, [["expression", ""]], "1", "0"]];
	if (count addedUIDList > 9) then
	{
		_removeMenu set [(_this select 1) + 3, ["Next", [12], "", -5, [["expression", "snext = true;"]], "1", "1"]];
	} else {
		_removeMenu set [(_this select 1) + 3, ["", [-1], "", -5, [["expression", ""]], "1", "0"]];
	};
	_removeMenu set [(_this select 1) + 4, ["Exit", [13], "", -5, [["expression", "removeUIDSelect = 'exitscript';"]], "1", "1"]];
	showCommandingMenu "#USER:_removeMenu";
};

//Hang around whilst the player decides
_j = 0;
_max = 10;
if (_max > 9) then {_max = 10;};
while {removeUIDSelect == ""} do {
	[_j, (_j + _max) min (count addedUIDList)] call removeUIDMenu;
	_j = _j + _max;
	waitUntil {removeUIDSelect != "" || snext};
	snext = false;
};

//Now we can remove the selected UID
if (removeUIDSelect != "exitscript") then {
	_addedPUIDS = _addedPUIDS - [removeUIDSelect];
	_plotPole setVariable ["AddedPUIDS", _addedPUIDS, true];
	cutText [format ["Successfully removed build rights from player UID %1", removeUIDSelect], "PLAIN DOWN"];
	PVDZE_veh_Update = [_plotPole,"gear"];
	publicVariableServer "PVDZE_veh_Update";
	if (isServer) then {
		PVDZE_veh_Update call server_updateObject;
	};
};