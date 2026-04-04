for(var i = 0 ; i < MAX_PLAYERS;i++) {
	var names = variable_struct_get_names(global.settings.keyBinds.p0); //All keybind names are the same for each player, 
	for(var n = 0 ; n < array_length(names);n++) {
		if(i <= playerCount) continue;
		if(GetInput(names[i], 1, i)) {
			AddPlayer(new Vector(players[0].x, players[0].y));
			o_Camera.setupRoom();
		}
	}
}