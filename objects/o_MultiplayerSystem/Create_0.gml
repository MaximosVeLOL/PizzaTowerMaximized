totalPlayers = 0;
maxPlayers = 2;

registerPlayer = function() {
	totalPlayers++;
	return totalPlayers;
}

removePlayer = function(PD) {
	for(var i = 0 ; i < maxPlayers;i++) {
		if(instance_find(o_PlayerParent, i).PD == PD) instance_destroy(instance_find(o_PlayerParent, i));
	}
	totalPlayers--;
}