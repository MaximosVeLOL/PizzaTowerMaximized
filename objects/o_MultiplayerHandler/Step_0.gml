if(o_GameManager.mode != "game") return;
for(var i = 0 ; i < MAX_PLAYERS;i++) {
	var names = variable_struct_get_names(global.settings.keyBinds.p0); //All keybind names are the same for each player, 
	if(i <= playerCount - 1) {
		if(GetInput("down", 0, i) && GetInput("dash", 0, i) && GetInput("up", 1, i)) { 
			RemovePlayer(i);
		}
		continue;
	}
	if(GetInput("dash", 1, i)) {
		AddPlayer(new Vector(players[0].x, players[0].y));
		o_Camera.setupRoom();
	}

}