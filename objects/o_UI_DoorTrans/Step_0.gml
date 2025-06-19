image_xscale += room == o_GameManager.transSettings.nextRoom ?  -1 : 1;
image_yscale += room == o_GameManager.transSettings.nextRoom ?  -1 : 1;
if(image_xscale == 50 && room != o_GameManager.transSettings.nextRoom) {
	//LogError("Going to room!\nInfo:\nNewLoc: " + string(o_GameManager.transSettings.newPos) + "\nNewRoom:" + string(o_GameManager.transSettings.nextRoom));
	room_goto(o_GameManager.transSettings.nextRoom);
	o_PlayerParent.x = o_GameManager.transSettings.newPos[0];
	o_PlayerParent.y = o_GameManager.transSettings.newPos[1];
	x = o_PlayerParent.x;
	y = o_PlayerParent.y;

	o_PlayerParent.tempVar[0] = 1;
}
if(image_xscale == 0) {
	o_GameManager.transSettings.nextRoom = -1;
	o_GameManager.transSettings.newPos = [-1,-1];
	o_GameManager.transSettings.state = "";
	instance_destroy();
}