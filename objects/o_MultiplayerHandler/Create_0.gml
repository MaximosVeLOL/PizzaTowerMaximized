#macro MAX_PLAYERS 4

playerCount = 1;
players = array_create(MAX_PLAYERS, noone);


AddPlayer = function(position) {
	players[playerCount] = instance_create_depth(position.x, position.y, 0, o_Player, {playerID : self.playerCount});
	//show_message(players[playerCount].playerID);
	playerCount++;
	if(playerCount > MAX_PLAYERS) {
		throw("Implement me");
	}
}

DefinePlayer = function(plr) {
	plr.playerID = playerCount;
	playerCount++;
}