image_xscale += faded ? -1 : 1;
image_yscale += faded ? -1 : 1;

if(image_xscale >= 10 && o_PlayerParent.image_alpha > 0 && !faded) { //The Pre-ETB video has a weird effect on the player, where he fades in with the door
	o_PlayerParent.image_alpha -= 0.1;
}
if(image_xscale <= 50 && o_PlayerParent.image_alpha < 1 && faded) {
	o_PlayerParent.image_alpha += 0.1;
}

if(image_xscale >= 60 && !faded) {
	faded = true;
	room_goto(o_GameManager.transSettings.nextRoom);
	o_PlayerParent.x = o_GameManager.transSettings.newPos[0]; 
	o_PlayerParent.y = o_GameManager.transSettings.newPos[1];
	x = o_GameManager.transSettings.newPos[0]; 
	y = o_GameManager.transSettings.newPos[1];
	o_PlayerParent.tempVar[0] = 1;
	o_GameManager.transSettings.newPos = [-1,-1];
	o_GameManager.transSettings.nextRoom = -1;
}
if(image_xscale == 0) instance_destroy();