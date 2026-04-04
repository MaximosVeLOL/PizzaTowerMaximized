if(global.settings.playerSettings.moveSet != Moveset.PreETB && !usable) instance_destroy();
velocity = new Vector();

Activate = function() {
	x = xstart;
	y = ystart;
	visible = true;
}

Deactivate = function() {
	visible = false;
	x = -100;
	y = -100;
}