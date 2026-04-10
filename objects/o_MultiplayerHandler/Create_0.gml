#macro MAX_PLAYERS 4

playerCount = 0;
rememberedCount = -1;
players = array_create(MAX_PLAYERS, noone);

AddPlayer = function(position) {
	if(playerCount + 1 > MAX_PLAYERS) {
		LogError("Failed to add player!");
		PlaySound(MaxGUI_error, true);
		return false;
	
	}
	players[playerCount] = instance_create_depth(position.x, position.y, 0, o_Player);
	players[playerCount].playerID = playerCount;
	//show_message(players[playerCount].playerID);
	playerCount++;
	return true;
};

DefinePlayer = function(plr, ID = -1) {
	plr.playerID = (ID == -1 ? playerCount : ID);
	players[playerCount] = plr;
	playerCount++;
};

RemovePlayer = function(index) {
	instance_destroy(players[index]);
	for(var i = index; i < playerCount - 1;i++) {
		players[i].playerID = i;
		players[i] = players[i + 1];
	}
	playerCount--;
}

RemoveAllPlayers = function() {
	rememberedCount = playerCount;
	for(var i = 0 ; i < playerCount;i++) {
		instance_destroy(players[i]);
		player[i] = noone;
	}
	playerCount = 0;
}

/*
if(instance_exists(o_Player)) {
	for(var i = 0 ; i < instance_number(o_Player);i++) {
		DefinePlayer(instance_find(o_Player, i), i);
	}
}
*/