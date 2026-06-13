frames++;
if(frames == 3) image_alpha = 0;
if(frames == 6) image_alpha = 0.8;
if(frames == 15) instance_destroy();
if(instance_exists(o_Player)) {
	if(global.settings.player.moveSet == Moveset.PreETB) {
		if(o_Player.state != PlayerState.Mach2) instance_destroy();
	}
	else {
		if(o_Player.state != PlayerState.Mach3 && o_Player.state != PlayerState.SuperJump && o_Player.state != PlayerState.MachRoll) instance_destroy();
	}
}