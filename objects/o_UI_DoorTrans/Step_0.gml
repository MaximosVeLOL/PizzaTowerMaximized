image_xscale += room = o_GameManager.transSettings.nextRoom ?  -1 : 1;
image_yscale += room = o_GameManager.transSettings.nextRoom ?  -1 : 1;
if(image_xscale == 50) {
	//LogError("Going to room!\nInfo:\nNewLoc: " + string(o_GameManager.transSettings.newPos) + "\nNewRoom:" + string(o_GameManager.transSettings.nextRoom));
	obj_player.x = o_GameManager.transSettings.newPos[0];
	obj_player.y = o_GameManager.transSettings.newPos[1];
	room_goto(o_GameManager.transSettings.nextRoom);
	x = obj_player.x;
	y = obj_player.y;
	obj_player.tempVar[0] = 1;
}
if(image_xscale == 0) instance_destroy();