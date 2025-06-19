var moveX = GetInput("right", 0, PD) - GetInput("left", 0, PD);
var moveY = GetInput("down", 0, PD) - GetInput("up", 0, PD);
switch(state) {
	case "normal":
		velocity[0] = movespeed * moveX;
		if(moveX != xscale) movespeed = 0;
		if(moveX != 0) {
			xscale = moveX;
			movespeed = movespeed < 6 ? movespeed + 0.5 : 6;
		}
		if(GetInput("jump", 0, PD)) velocity[1] = -9;
		if(PLAYER_GROUNDED) {
			sprite_index = sprite_player_idle_suprise;
		}
		else {
			sprite_index = spr_player_mach2jump;
			playSound(sfx_spin);
		}
	break;
}
CollideAndMove(mass, 20);