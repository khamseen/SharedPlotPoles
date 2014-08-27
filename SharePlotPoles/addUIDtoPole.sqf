//Add UIDs to Plot Pole by Rosska85
private ["_addingSelf","_plotPole","_PUIDtoAdd","_currentPUIDS"];

_plotPole = _this select 3 select 0;
_addingSelf = _this select 3 select 1;
_PUIDtoAdd = if (_addingSelf) then {getPlayerUID player;} else {player getVariable ["PUIDtoAdd", 0];};
_addedPUIDS = _plotPole getVariable ["AddedPUIDS", []];

	//If the player already has rights on the pole, don't add them again
	if (_PUIDtoAdd in _addedPUIDS) then {
		cutText [format ["Player UID %1 already has build rights on this plot pole.", _PUIDtoAdd], "PLAIN DOWN"];
		breakout "exit";
	} else {
		_addedPUIDS set [count _addedPUIDS, _PUIDtoAdd];
		_plotPole setVariable ["AddedPUIDS", _addedPUIDS, true];
		cutText [format ["Successfully given build rights to player UID %1", _PUIDtoAdd], "PLAIN DOWN"];
		PVDZE_veh_Update = [_plotPole,"gear"];
		publicVariableServer "PVDZE_veh_Update";
		if (isServer) then {
			PVDZE_veh_Update call server_updateObject;
		};
	};