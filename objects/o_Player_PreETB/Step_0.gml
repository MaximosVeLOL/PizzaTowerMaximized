var moveX = GetInput("right", 0) - GetInput("left", 0);
var moveY = GetInput("down", 0) - GetInput("up", 0);
if(keyboard_check_pressed(vk_tab)) state = state != "noclip" ? "noclip" : "normal";
switch(state) {
	
	case "normal":
		velocity[0] = moveX * movespeed;
		switch(tempVar[0]) {
			case 0: //walking
				if(moveX != 0) {
					playSound(sfx_footstep);
					image_speed = movespeed / 4;
					sprite_index = spr_player_move;
					movespeed = movespeed < 4 ? movespeed + 0.5 : 4;
					if(GetInput("dash", 0) && !PLAYER_TOUCHING) {
						setState("mach1", true, true);
					}
					if(moveX != xscale) {
						tempVar[0] = 1;
						image_speed = 1;
					}
				}
				else {
					movespeed = 0;
					sprite_index = spr_player_idle;
				}
				if(GetInput("jump", 1)) {
					setState("jump");
					playSound(sfx_jump);
					velocity[1] = -9;
				}

				if(!PLAYER_GROUNDED) setState("jump");
				if(GetInput("down", 1)) {
					setState("crouch");
				}
				

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
		
		if(GetInput("jump", 2) && velocity[1] < 0) velocity[1] /= 2;
		if(moveX != xscale) movespeed = 0;
		if(moveX != 0) {
			xscale = moveX;
			movespeed = movespeed < 4 ? movespeed + 0.5 : 4;
		}
		if(GetInput("down", 1)) {
			setState("freefall");
			tempVar[0] = 3;
			PlaySound(sfx_woosh);
		}
		if(PLAYER_GROUNDED) {
			setState("normal");
		}
	break;
	
	case "mach1":
		CreateEffect({sprite_index : sprite_effect_dashcloud, image_xscale : self.xscale});
		velocity[0] = movespeed * xscale;
		movespeed += 0.2;
		sprite_index = spr_player_run;
		tempVar[0]++;
		playSound(sfx_mach1);
		if(GetInput("dash", 2) || moveX != xscale || PLAYER_TOUCHING) {
			if(moveX != 0 ) xscale = moveX;
			setState("normal");
		}
		if(tempVar[0] >= 35) {
			setState("mach2");
		}
	break;
	
	case "mach2":
		image_speed = 2;
		
		
		velocity[0] = movespeed * xscale;
		movespeed = 10;
		if(tempVar[1] == 0) {
			tempVar[1] = 6;
			instance_create_depth(x,y,0,o_P_Mach3Effect);
		}
		tempVar[1]--;
		if(PLAYER_GROUNDED) {
			CreateEffect({sprite_index : sprite_effect_dashcloud, image_xscale : self.xscale});
			playSound(sfx_mach2);
			if(GetInput("jump", 1)) {
				velocity[1] = -9;
			} 
					if(global.settings.playerSettings.PreETB_betterRunning && (GetInput("dash", 2) || moveX != xscale) ) setState("CUSTOMmachSlide");

		}
		else if(GetInput("jump", 2) && velocity[1] < 0) velocity[1] /= 2;
		
		
		if(PLAYER_TOUCHING) {
			setState("bump");
			PlaySound(sfx_bump);
			ShakeCamera(10, 1/2);
			velocity[1] = -6;
		}
		sprite_index = spr_player_run;
	break;
	
	case "CUSTOMmachSlide": //This looks very similar to the slip state...
		velocity[0] = movespeed * xscale;
		sprite_index = animVar ? spr_player_machslide : spr_player_machslide_start;
		if(IMAGE_COMPLETE && !animVar) animVar = true;
		movespeed -= 0.2;
		if(PLAYER_TOUCHING) {
			setState("bump");
			PlaySound(sfx_bump);
			velocity[1] = -3;
		}
		if(movespeed <= 0) {
			if(moveX != xscale && moveX != 0 && GetInput("dash")) {
				xscale = moveX;
				setState("mach1");
			}
			else setState("normal");
		}
		
	break;
	
	case "bump":
		
		velocity[0] = movespeed * xscale;
		sprite_index = spr_player_bump;
		tempVar[0] += TIME_BASE;
		if (tempVar[0] >= 1/3) { //M_OPTI - Is the math correct?
			setState("normal");
			if(moveX != 0) xscale = moveX;
			if(place_meeting(x,y - 1, o_C_Parent) || place_meeting(x,y,o_C_Parent)) setState("crouch");
		}
		movespeed = PLAYER_GROUNDED ? 0 : -2.5;
	break;
	
	case "door": //Directly copied and pasted!
		switch(tempVar[0]) {
			case 0:
				velocity[0] = 0;
				sprite_index = spr_player_door_in;
				SPRITE_NO_REPEAT;
			break;
			
			case 1:
				image_speed = 1;
				sprite_index = spr_player_door_out;
				SPRITE_NO_REPEAT;
				if(round(image_index) == image_number) setState("normal");
			break;
			
			case 2:
				sprite_index = spr_player_door_victory;
				if(round(image_index) == 17) playSound(choose(va_happy1, va_happy2, va_happy3));
				SPRITE_NO_REPEAT;
			break;
		}
	break;
	
	case "hurt":
		sprite_index = spr_player_hurt;
		if(PLAYER_GROUNDED) {
			velocity[1] = -5 + (tempVar[0] * 2);
			tempVar[0]++;
		}
		velocity[0] = tempVar[0] < 2 ? 3 * xscale : 0;
		if(round(image_index) == image_number) {
			setState("normal");
			stunStuff.invincibleFrames = 200;
		}
		if(tempVar[1] != 0 || global.settings.gameplaySettings.goonerMode) {
			tempVar[1]--;
			score -= 10;
			with(instance_create_depth(x,y,0,o_Le_Points)) {
				canMove = true;
				velocity = [other.image_xscale * random_range(3, 5), random_range(-3, -10)]
			}
		}
		if(PLAYER_TOUCHING) xscale *= -1;
	break;
	
	case "ladder":
		mass = 0;
		velocity[0] = 0;
		tempVar[1]++;
		if((!place_meeting(x,y, o_Le_Ladder) || PLAYER_GROUNDED) && tempVar[1] > 10) setState("normal");
		switch(moveY) {
			case -1: //Up
				velocity[1] = -2;
				sprite_index = spr_player_ladderup
				playSound(sfx_climb);			
			break;
			
			case 1:
				velocity[1] = 6;
				sprite_index = spr_player_ladderdown;			
			break;
			
			case 0:
				velocity[1] = 0;
				sprite_index = spr_player_ladder;
			break;
		}
		if(GetInput("jump", 1)) {
			setState("jump");
			playSound(sfx_jump);
			velocity[1] = -9;
		}
	break;
	
	
	case "crouch":
		mask_index = spr_player_mask_crouch;
		velocity[0] = movespeed * xscale;
		if(moveX != xscale) movespeed = 0;
		if(moveX != 0) {
			xscale = moveX;
			movespeed += movespeed <= 4 ? 0.5 : 0;
			movespeed = clamp(movespeed, -4, 4);
		}
		switch(tempVar[0]) {
			case 0:
				
				if(!animVar) {
					sprite_index = spr_player_crouch;
					if(round(image_index) == image_number) animVar = true;
				}
				else sprite_index = spr_player_crouching;
				if(moveX != 0) {
					sprite_index = spr_player_crouch_crawl;
					playSound(sfx_crawl);	
				}
				if(!place_meeting(x,y - 1, o_C_Wall)) {
					if(!GetInput("down", 0)) {
						setState("normal");
						mask_index = spr_player_mask;
					}
					if(GetInput("jump", 1)) {
						animVar = false;
						tempVar[0] = 1;
						playSound(sfx_jump);
						CreateEffect({sprite_index : sprite_effect_dust, image_xscale : o_PlayerParent.xscale});
						velocity[1] = -8;
						mask_index = spr_player_mask;	
					}
				}
				if(!PLAYER_GROUNDED) tempVar[0] = 1;
			break;
			
			case 1:
				tempVar[1] += TIME_BASE;
				mask_index = spr_player_mask_crouch;
				if(!animVar) {
					sprite_index = spr_player_crouch_jumping;
					if(round(image_index) == image_number || velocity[1] > 0) animVar = true;
				}
				else sprite_index = spr_player_crouch_falling;
				if(tempVar[1] >= 0.8) setState("freefall");
				if(PLAYER_GROUNDED) {
					animVar = false;
					tempVar[0] = 0;
					tempVar[1] = 0;
				}
				
				
			break;
		}
	break;
	
	case "freefall":
		velocity[0] = 0;
		switch(tempVar[0]) {
			case 0:
				tempVar[0] = 1; //For the other stuff, as in the metal blocks, and enemies.
			break;
			
			case 1:
				sprite_index = spr_player_freefalling;
				velocity[1]++;
				if(PLAYER_GROUNDED) tempVar[0] = 2;
			break;
			
			case 2:
				sprite_index = spr_player_freefall_impact;
				if(IMAGE_COMPLETE) {
					setState("normal");
					if(moveX != xscale && moveX != 0) xscale = moveX;
				}
			break;
			
			case 3:
				velocity = [0,0];
				mass = 0;
				sprite_index = spr_player_freefall_prep;
				tempVar[1] += TIME_BASE;
				
				if(tempVar[1] >= 1/2) {
					PlaySound(sfx_supermove);
					tempVar[0] = 1;
					mass = 0.5;
				}
			break;
		}

	break;
	
	case "slip":
		sprite_index = spr_player_slip;
		velocity[0] = movespeed * xscale;
		movespeed -= 0.2;
		if(movespeed <= 0) setState("normal");
	break;
	
	case "noclip":
		movespeed = GetInput("dash", 0) ? 20 : 10;
		x += moveX * movespeed;
		y += moveY * movespeed;
		return;
	break;
	
	case "transition":
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