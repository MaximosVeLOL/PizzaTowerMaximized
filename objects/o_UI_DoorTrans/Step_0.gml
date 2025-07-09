image_xscale += faded ? -1 : 1;
image_yscale += faded ? -1 : 1;

if(image_xscale >= 50 && !faded) {
	faded = true;
	room_goto(o_GameManager.transSettings.nextRoom);
	o_PlayerParent.x = o_GameManager.transSettings.newPos[0]; 
	o_PlayerParent.y = o_GameManager.transSettings.newPos[1];
	x = o_GameManager.transSettings.newPos[0]; 
	y = o_GameManager.transSettings.newPos[1];
	o_GameManager.transSettings.newPos = [-1,-1];
	o_GameManager.transSettings.nextRoom = -1;
	o_PlayerParent.tempVar[0] = 1;
}
if(image_xscale == 0) instance_destroy();