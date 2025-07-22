/*
var pInfo = array_create(maxPlayers - 1, 0xFF);
var player = noone;
for(var i = 0 ; i < maxPlayers - 1 ;i++) { //Player 1 on top
	player = instance_find(o_PlayerParent, i);
	if(player == noone) throw("cannot find player");
	pInfo[i] = {
		obIndex : player.object_index,
		state : player.state,
		tempVar : player.tempVar,
		pos : [player.x, player.y],
		
	};
	instance_destroy(player);
}
for(var i = 0; i < maxPlayers - 1 ;i++) { //Player 1 on top
	show_message(pInfo[i]);
	player = instance_create_depth(pInfo[i].pos[0], pInfo[i].pos[1], 0, pInfo[i].obIndex);
	player.setState(pInfo[i].state);
	player.tempVar = pInfo[i].tempVar;
	player.PD = i + 1;
}