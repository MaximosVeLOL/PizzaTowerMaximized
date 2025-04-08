totalPlayers = 0;
prefPD = undefined;
registerPlayer = function() {
	totalPlayers++;
	return totalPlayers;
}

removePlayer = function(PD) {
	for(var i = 0 ; i < totalPlayers; i++) {
		if(instance_find(obj_player, i).PD == PD) {
			instance_destroy(instance_find(obj_player, i));
			break;
		}
	}
	totalPlayers--;
}