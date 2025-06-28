var moveX = GetInput("right", 0, PD) - GetInput("left", 0, PD);
var moveY = GetInput("down", 0, PD) - GetInput("up", 0, PD);
switch(state) {
	case "normal":
		velocity[0] = movespeed * moveX;
		if(moveX != xscale) movespeed = 0;
		if(moveX != 0) {
			sprite_index = sprite_level_noise_walk;
			movespeed = movespeed < 2 ? movespeed + 0.5 : 2;
			xscale = moveX;
		}
		else {
			sprite_index = sprite_level_noise_button;
			image_index = 0;
		}
		if(GetInput("dash", 1, PD)) setState("button");
	break;
	
	case "button":
		sprite_index = sprite_level_noise_button;
		SPRITE_NO_REPEAT;
		if(IMAGE_COMPLETE) setState("normal");
	break;
}