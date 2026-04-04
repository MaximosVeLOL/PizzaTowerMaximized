#macro MAX_PLAYERS 4

playerCount = 0;
players = array_create(MAX_PLAYERS, noone);

AddPlayer = function(position) {
	if(playerCount + 1 > MAX_PLAYERS) {
		PlaySound(MaxGUI_error, true);
		return false;
	
	}
	players[playerCount] = instance_create_depth(position.x, position.y, 0, o_Player);
	players[playerCount].playerID = playerCount;
	//show_message(players[playerCount].playerID);
	playerCount++;
	return true;
}

DefinePlayer = function(plr) {
	plr.playerID = playerCount;
	playerCount++;
}