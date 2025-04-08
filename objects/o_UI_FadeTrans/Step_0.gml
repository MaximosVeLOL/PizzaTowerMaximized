alpha += faded ? -0.05 : 0.05;
if(alpha == 1 && !faded) {
	room_goto(o_GameManager.transSettings.nextRoom);
	with(obj_player) {
		x = o_GameManager.transSettings.newPos[0];
		y = o_GameManager.transSettings.newPos[1];
	}
	faded = true;
}
if(alpha == 0 && faded) {
	obj_player.state = o_GameManager.transSettings.state;
	instance_destroy();
}