image_xscale += faded ? -1 : 1;
image_yscale += faded ? -1 : 1;

if(image_xscale >= 10 && o_Player.image_alpha > 0 && !faded) { //The Pre-ETB video has a weird effect on the player, where he fades in with the door
	o_Player.image_alpha -= 0.1;
}
if(image_xscale <= 50 && o_Player.image_alpha < 1 && faded) {
	o_Player.image_alpha += 0.1;
}

if(image_xscale >= 60 && !faded) {
	faded = true;
	room_goto(o_GameManager.transSettings.nextRoom);
	o_Player.x = o_GameManager.transSettings.newPos.x; 
	o_Player.y = o_GameManager.transSettings.newPos.y;
	x = o_GameManager.transSettings.newPos.x; 
	y = o_GameManager.transSettings.newPos.y;
	o_Player.tempVar[0] = 1;
	o_GameManager.transSettings.newPos = new Vector(-1, -1);
	o_GameManager.transSettings.nextRoom = -1;
}
if(image_xscale == 0) instance_destroy();