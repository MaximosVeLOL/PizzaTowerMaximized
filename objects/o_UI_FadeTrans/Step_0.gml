//alpha += faded ? -0.05 : 0.05; //This relies heavily on the game manager, so just don't use it (when saving fps) !
alpha += faded ? -0.1 : 0.1; //Remain original to our ancestors.
if(alpha == 1 && !faded) {
	room_goto(o_GameManager.transSettings.nextRoom);
	if(instance_exists(o_Player)) {
		with(o_Player) {
			x = o_GameManager.transSettings.newPos[0];
			y = o_GameManager.transSettings.newPos[1];
		}
	}
	faded = true;
}
if(alpha <= 0.5 && faded && o_Player.state != o_GameManager.transSettings.state) {
	o_Player.state = o_GameManager.transSettings.state;
}
if(alpha == 0) {
	o_GameManager.transSettings.nextRoom = -1;
	o_GameManager.transSettings.newPos = [-1,-1];
	o_GameManager.transSettings.state = "";
	instance_destroy();
}