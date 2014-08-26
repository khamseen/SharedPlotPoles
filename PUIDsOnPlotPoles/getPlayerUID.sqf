private ["_targetPlayer","_targetPlayerUID"];
_targetPlayer = _this select 3;
_targetPlayerUID = (getPlayerUID _targetPlayer);
player setVariable ["PUIDtoAdd", _targetPlayerUID];
cutText [format["Got target Player UID: %1. Select 'Give player build rights' on plot pole to add their UID", _targetPlayerUID], "PLAIN DOWN"];