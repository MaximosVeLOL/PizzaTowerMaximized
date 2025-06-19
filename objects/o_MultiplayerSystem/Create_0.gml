totalPlayers = 0;
prefPD = undefined;

registerPlayer = function() {
	totalPlayers++;
	return totalPlayers;
}

removePlayer = function(PD) {
	instance_destroy(instance_find(o_PlayerParent, PD));
	totalPlayers--;
}


forEachPlayer = function(func) {
	for(var i = 0 ; i < totalPlayers;i++) {
		func(instance_find(o_PlayerParent, i));
	}
}