var moveX = GetInput("right", 0) - GetInput("left", 0);
var moveY = GetInput("down", 0) - GetInput("up", 0);
switch(state) {
	case "normal":
		velocity[0] = movespeed * moveX;
		if(moveX != xscale) movespeed = 0;
		if(moveX != 0) {
			xscale = moveX;
			movespeed = movespeed < 6 ? movespeed + 0.5 : 6;
		}
		if(GetInput("jump", 0)) velocity[1] = -9;
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