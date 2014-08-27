private ["_targetPlayer","_targetPlayerUID"];
//_targetPlayer = _this select 3;
//_targetPlayerUID = (getPlayerUID _targetPlayer);
_targetPlayerUID = "12345678";
player setVariable ["PUIDtoAdd", _targetPlayerUID];
cutText [format["Got target Player UID: %1. Select 'Add Player UID' on plot pole to give them build rights", _targetPlayerUID], "PLAIN DOWN"];