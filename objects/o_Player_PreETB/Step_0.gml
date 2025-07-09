var moveX = GetInput("right", 0, PD) - GetInput("left", 0, PD);
var moveY = GetInput("down", 0, PD) - GetInput("up", 0, PD);
if(keyboard_check_pressed(vk_tab)) state = state != "noclip" ? "noclip" : "normal";
switch(state) {
	
	case "normal":
		velocity[0] = moveX * movespeed;
		switch(tempVar[0]) {
			case 0: //walking
				if(moveX != xscale && moveX != 0) tempVar[0] = 1;
				if(moveX != 0) {
					playSound(sfx_footstep);
					image_speed = movespeed / 4;
					sprite_index = spr_player_move;
					movespeed = movespeed < 4 ? movespeed + 0.5 : 4;
				}
				else sprite_index = spr_player_idle;
				if(GetInput("jump", 1, PD)) {
					setState("jump");
					playSound(sfx_jump);
					velocity[1] = -9;
				}
				if(!PLAYER_GROUNDED) setState("jump");
			break;
			
			case 1: //Turning
				movespeed = 0;
				sprite_index = spr_player_turn;
				if(IMAGE_COMPLETE) {
					image_speed = 1;
					xscale = -xscale;
					tempVar[0] = 0;
				}
			break;
		}
	break;
	
	case "jump":
		velocity[0] = moveX * movespeed;
		var spr = [spr_player_jump, spr_player_fall];
		if(moveX != 0) spr = [spr_player_jump_moving, spr_player_fall_moving];
		if(!animVar) {
			sprite_index = spr[0];
			SPRITE_NO_REPEAT;
			animVar = IMAGE_COMPLETE || velocity[1] > 0;
		}
		else sprite_index = spr[1];
		
		if(GetInput("jump", 2, PD) && velocity[1] < 0) velocity[1] /= 2;
		if(moveX != xscale) movespeed = 0;
		if(moveX != 0) {
			xscale = moveX;
			movespeed = movespeed < 4 ? movespeed + 0.5 : 4;
		}
		if(PLAYER_GROUNDED) {
			setState("normal");
		}
	break;
	
	case "noclip":
		movespeed = GetInput("dash", 0, PD) ? 20 : 10;
		x += moveX * movespeed;
		y += moveY * movespeed;
		return;
	break;
	
	
	default:
		show_message("State not implemented! State: " + state);
		setState("normal");
	break;
}
if(stunStuff.invincibleFrames > 0 && state != "hurt") {
	stunStuff.flashing = !stunStuff.flashing;
	stunStuff.invincibleFrames--;
}
if(xscale != 1 && xscale != -1) show_message("Scale not in range! \n" + state);

CollideAndMove(mass, 30);