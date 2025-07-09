totalPlayers = 0;
maxPlayers = 3;
prefPD = undefined;

registerPlayer = function() {
	totalPlayers++;
	return totalPlayers;
}

removePlayer = function(PD) {
	instance_destroy(instance_find(o_PlayerParent, PD));
	totalPlayers--;
}