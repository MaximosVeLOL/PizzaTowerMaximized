frames++;
if(frames == 3) image_alpha = 0;
if(frames == 6) image_alpha = 0.8;
if(frames == 15) instance_destroy();
if(instance_exists(o_Player)) {
	if(global.settings.playerSettings.moveSet == Moveset.PreETB) {
		if(o_Player.state != "mach2") instance_destroy();
	}
	else {
		if(o_Player.state != "mach3" && o_Player.state != "superJump" && o_Player.state != "machroll") instance_destroy();
	}
}