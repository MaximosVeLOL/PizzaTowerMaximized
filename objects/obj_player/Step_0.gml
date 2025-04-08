var moveX = GetInput("right") - GetInput("left");
var moveY = GetInput("down") - GetInput("up");
if(keyboard_check_pressed(vk_tab)) state = state != "noclip" ? "noclip" : "normal";
switch(state) {
	case "normal":
		velocity[0] = moveX * movespeed;
		if(moveX != xscale) movespeed = 0;
		if(moveX != 0) {
			playSound(sfx_footstep);
			sprite_index = spr_player_move;
			xscale = moveX;
			movespeed = movespeed < 6 ? movespeed + 0.5 : 6;
			image_speed = movespeed/6;
			tempVar[0] = 0;
		}
		else {
			
			tempVar[0]++;
			sprite_index = spr_player_idle;
			
			if(tempVar[0] >= 400) {
				sprite_index = choose(sprite_player_idle_suprise, spr_player_bump); 
				tempVar[0] = 0;
			}
			if(GetInput("up", 1) && PLAYER_GROUNDED) setState("highJump", true);
			
		}
		movespeed = movespeed > 6 ? movespeed - 0.5 : movespeed;
		
		if(PLAYER_GROUNDED && GetInput("jump")) {
			setState("jump");
			instance_create_depth(x,y,0,o_P_Effect, {sprite_index : sprite_effect_dust, image_xscale : obj_player.xscale});
			velocity[1] = -9;
		}
		if(PLAYER_GROUNDED) {
			if(GetInput("jump")) {
				setState("jump");
				instance_create_depth(x,y,0,o_P_Effect, {sprite_index : sprite_effect_dust, image_xscale : obj_player.xscale});
				velocity[1] = -9;
			}
			if(GetInput("down")) setState("crouch");
			if(GetInput("dash") && !PLAYER_TOUCHING) setState("mach1");
		}
		else setState("jump");
	break;
	
	case "mach1":
		sprite_index = spr_player_mach1;
		playSound(sfx_mach1);
				if(moveX != xscale && moveX != 0 || GetInput("dash", 2)) {
					setState("normal");
				}
				movespeed += movespeed <= 8 ? 0.2 : 0;
				velocity[0] = round(movespeed) * xscale;
				if(PLAYER_GROUNDED) {
					if(GetInput("down")) setState("crouchslide", false);
					tempVar[0]++;
					if(tempVar[0] >= 35) {
						instance_create_depth(x,y,0,o_P_Effect, {sprite_index : sprite_effect_dust});
						setState("mach2", false);
					}
			
					if(GetInput("jump")) {
						setState("jump");
						instance_create_depth(x,y,0,o_P_Effect, {sprite_index : sprite_effect_dust, image_xscale : obj_player.xscale});
						playSound(sfx_jump);
						velocity[1] = -9;
					}
					if(PLAYER_TOUCHING) {
						setState("normal");
						
					}
				}
				else setState("jump", false);
		
			break;
	
			case "mach2":
				movespeed = 10;
				velocity[0] = xscale * movespeed;
				if((moveX != xscale && moveX != 0 || !GetInput("dash")) && PLAYER_GROUNDED) {
					setState("machslide");
					tempVar[0] = 35;
				}
				
				if(PLAYER_GROUNDED) {
					if(!instance_exists(o_P_Effect)) instance_create_depth(x,y,0,o_P_Effect, {sprite_index : sprite_effect_dashcloud, image_xscale : xscale});
					sprite_index = spr_player_mach2;
					if(GetInput("down")) setState("crouchslide", false);
					playSound(sfx_mach2);
					tempVar[0]++;
					if(tempVar[0] >= 100) {
						setState("mach3", false);
						instance_create_depth(x,y,0,o_P_Effect, {sprite_index : sprite_effect_dust});
						instance_create_depth(x,y,0,o_P_StateInitEffect);
					}
					
					if(GetInput("jump", 1)) velocity[1] = -9;
				}
				else {
					setState("machfreefall");
				}
				if(PLAYER_TOUCHING) {
					setState("bump");
					PlaySound(sfx_bump);
					instance_create_depth(x,y,0,o_P_Effect, {sprite_index : sprite_effect_bump});
				}
			break;
			
			case "mach3":
				movespeed = 14;
				velocity[0] = xscale * movespeed;
				if(tempVar[1] == 0) {
					tempVar[1] = 6;
					instance_create_depth(x,y,0,o_P_Mach3Effect);
				}
				tempVar[1]--;
				sprite_index = spr_player_mach3;
				playSound(sfx_superdash);
				if(GetInput("up")) setState("superJump");
				if((moveX != xscale && moveX != 0 || !GetInput("dash"))) {
					setState("machslide", false);
					tempVar[0] = 35;
				}
				if(PLAYER_GROUNDED) {
					if(!instance_exists(o_P_Effect)) instance_create_depth(x,y,0,o_P_Effect, {sprite_index : sprite_effect_dashcloud, image_xscale : xscale});
					if(GetInput("down")) setState("machroll", false);
				}
				if(PLAYER_TOUCHING) {
					setState("bump");
					ShakeScreen(2);
					PlaySound(sfx_bump);
					instance_create_depth(x,y,0,o_P_Effect, {sprite_index : sprite_effect_bump});
				}
				if(GetInput("jump") && PLAYER_GROUNDED) {
					velocity[1] = -9;
				}
				if(GetInput("jump", 2) && velocity[1] < 0) velocity[1] /= 2;
			break;
			
			case "machslide":
				if(!animVar) {
					sprite_index = spr_player_machslide_start;
					if(round(image_index) == image_number) animVar = true;
				}
				else sprite_index = spr_player_machslide;
				velocity[0] = movespeed * xscale;
				movespeed -= 0.4;
				if(movespeed <= 0) {
					if(moveX != 0) xscale = moveX;
					if(GetInput("dash")) {
						setState("mach2", false);
					}
					else setState("normal");
				}
				if(PLAYER_TOUCHING) {
					setState("bump");
					PlaySound(sfx_bump);
					instance_create_depth(x,y,0,o_P_Effect, {sprite_index : sprite_effect_bump});
				}
			break;
			
			case "crouchslide":
				velocity[0] = movespeed * xscale;
				movespeed -= 0.2;
				if(!GetInput("down") && tempVar[0] >= 35) setState("mach2", false);
				if(movespeed <= 0) {
					setState("crouch");
				}
				
				if(PLAYER_TOUCHING) {
					setState("bump");
					PlaySound(sfx_bump);
					instance_create_depth(x,y,0,o_P_Effect, {sprite_index : sprite_effect_bump});
					velocity[1] = -3;
				}
			break;
			
			case "machroll":
				sprite_index = spr_player_machroll;
				playSound(sfx_superdash);
				mask_index = spr_player_mask_crouch;
				movespeed = 12;
				if(tempVar[1] == 0) {
					tempVar[1] = 6;
					instance_create_depth(x,y,0,o_P_Mach3Effect);
				}
				tempVar[1]--;
				velocity[0] = movespeed * xscale;
				if(!GetInput("down")) {
					setState("mach3", false);
					sprite_index = spr_player_mask;
					tempVar[0] = 35;
				}
				if(!PLAYER_GROUNDED) {
					setState("machfreefall");
					mask_index = spr_player_mask;
				}
				if(PLAYER_TOUCHING) {
					setState("bump");
					PlaySound(sfx_bump);
					instance_create_depth(x,y,0,o_P_Effect, {sprite_index : sprite_effect_bump});
					mask_index = spr_player_mask;
					velocity[1] = -3;
				}
			break;
			
			
			case "machfreefall":
				sprite_index = spr_player_mach2jump;
				playSound(sfx_spin);
				velocity[0] = xscale * 10;
				tempVar[0]++;
				if(PLAYER_GROUNDED && tempVar[0] > 1) {
					if(!GetInput("dash")) { 
						setState("freefall");
						tempVar[0] = 2;
					}
					else {
						setState("mach2");
						tempVar[0] = 35;
					}
				}
				if(PLAYER_TOUCHING) {
					setState("bump");
					PlaySound(sfx_bump);
					instance_create_depth(x,y,0,o_P_Effect, {sprite_index : sprite_effect_bump});
					velocity[1] = -3;
				}
			break;
	
	case "jump":
		if(moveX != xscale) movespeed = 0;
		var spr = [spr_player_jump, spr_player_fall];
		if(moveX != 0) {
			spr = [spr_player_jump_moving, spr_player_fall_moving];
			xscale = moveX;
		}
		if(!animVar && velocity[1] < 0) {
			playSound(sfx_jump);
			sprite_index = spr[0];
			animVar = true;
		}
		
		movespeed = movespeed < 6 ? movespeed + 0.5 : 6;
		velocity[0] = moveX * movespeed;
		if(GetInput("jump", 2) && velocity[1] < 0) velocity[1] /= 2;
		if(round(image_index) == image_number || velocity[1] > 0) sprite_index = spr[1];
		if(GetInput("down")) setState("freefall");
		if(PLAYER_GROUNDED) setState("normal");
	break;
	
	case "bump":
		velocity[0] = -2.5 * xscale;
		sprite_index = spr_player_bump;
		tempVar[0]++;
		if (PLAYER_GROUNDED && velocity[1] >= 0 && tempVar[0] > 10) {
			setState("normal");
		}
		
	break;
	
	case "noclip":
		velocity = [0,0];
		x += moveX * 10;
		y += moveY * 10;
		return;
	break;
	
	
	case "superJump":
		velocity = [0,0];
		switch(tempVar[0]) {
			case 0:
				mass = 0;
				sprite_index = spr_player_suJump_prep
				tempVar[2]++;
				if(tempVar[2] > 30) {
					tempVar[0] = 1;
					playSound(sfx_supermove);
				}
			break;
			
			case 1:
				mass = 1/2;
				sprite_index = spr_player_suJump;
				velocity = [0, -movespeed];
				movespeed += 0.5;
				if(place_meeting(x,y - 1, o_C_Parent)) {
					tempVar[0] = 2;
					movespeed = 0;
					sprite_index = spr_player_suJump_hit;
				}
				if(GetInput("dash", 1)) {
					velocity = [0,0];
					if(moveX != 0) xscale = moveX;
					setState("machfreefall");
				}
			break;
			
			case 2:
				mass = 0;
				if(round(image_index) == image_number) {
					setState("jump");
				}
			break;
		}
	break;
	
	case "highJump":
		switch(tempVar[0]) {
			case 0:
				sprite_index = spr_player_highjump_prep;
				SPRITE_NO_REPEAT;
				velocity = [0,0];
				if(GetInput("jump", 1) && round(image_index) == image_number) {
					playSound(sfx_jump);
					velocity[1] = -12;
					tempVar[0] = 1;
				}
				if(GetInput("up", 2)) setState("normal");
			break;
			
			case 1:
				velocity[0] = movespeed * xscale;
				sprite_index = spr_player_highjump;
				if(moveX != xscale) movespeed = 0;
				if(moveX != 0) {
					xscale = moveX;
					movespeed = movespeed < 4 ? movespeed + 1/2 : 4;
				}
				
				if(PLAYER_GROUNDED) {
					if(GetInput("up"))	{
						tempVar[0] = 0;
						image_index = 0;
					}
					else setState("normal");
				}
			break;
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
				if(moveX != 0) sprite_index = spr_player_crouch_crawl;
				if(!place_meeting(x,y - 1, o_C_Wall)) {
					if(!GetInput("down")) {
						setState("normal");
						mask_index = spr_player_mask;
					}
					if(GetInput("jump")) {
						animVar = false;
						tempVar[0] = 1;
						playSound(sfx_jump);
						instance_create_depth(x,y,0,o_P_Effect, {sprite_index : sprite_effect_dust, image_xscale : obj_player.xscale});
						velocity[1] = -8;
						mask_index = spr_player_mask;	
					}
				}
			break;
			
			case 1:

				if(!animVar) {
					sprite_index = spr_player_crouch_jumping;
					if(round(image_index) == image_number || velocity[0] > 0) animVar = true;
				}
				else sprite_index = spr_player_crouch_falling;
				
				if(PLAYER_GROUNDED) {
					animVar = false;
					tempVar[0] = 0;
				}
				
				
			break;
		}
	break;
	
	case "freefall":
		if(PLAYER_GROUNDED) {
			tempVar[0] = 2;
		}
		switch(tempVar[0]) {
			case 0: //Prep
				tempVar[1]++;
				sprite_index = spr_player_freefall_prep;
				velocity[0] = movespeed * moveX;
				if(moveX != xscale) movespeed = 0;
				if(moveX != 0) {
					movespeed = movespeed < 4 ? movespeed + 1/4 : 4;
					xscale = moveX;
				}
				if(tempVar[1] >= 15) {
					velocity[0] = 0;
					tempVar[1] = 0;
					tempVar[0] = 1;
				}
			break;
			
			case 1: //Falling
				sprite_index = spr_player_freefalling;
				mass += 0.01;
				if(mass == 0.805) {
					setState("superslam");
				}

			break;
			
			case 2: //Impact
				sprite_index = spr_player_freefall_impact;
				SPRITE_NO_REPEAT;
				if(round(image_index) == image_number) {
					if(mass >= 0.805) {
						setState("machfreefall");
						velocity[1] = -7;
					}
					else setState("normal");
					mass = 1/2;
				}
			break;
		}
	break;
	
	case "superslam":
		sprite_index = spr_player_freefalling;
		if(PLAYER_GROUNDED) {
			setState("freefall");
			xscale = moveX != 0 ? moveX : xscale;
			tempVar[0] = 2;
		}
	break;
	
	case "ladder":
		mass = 0;
		velocity[0] = 0;
		if(!place_meeting(x,y, o_Le_Ladder) || PLAYER_GROUNDED) setState("normal");
		sprite_index = spr_player_ladder;
		velocity[1] = 0;
		if(moveY == -1) {
			velocity[1] = -2;
			sprite_index = spr_player_ladderup
			playSound(sfx_climb);
		}
		if(moveY == 1) {
			velocity[1] = 6;
			sprite_index = spr_player_ladderdown;
		}
		if(GetInput("jump")) {
			setState("jump");
			playSound(sfx_jump);
			velocity[1] = -9;
		}
	break;
	
	//Transition Stuff here
	case "transition":
		return;
	break;
	
	case "door":
		switch(tempVar[0]) {
			case 0:
				sprite_index = spr_player_door_in;
				SPRITE_NO_REPEAT;
			break;
			
			case 1:
				sprite_index = spr_player_door_out;
				SPRITE_NO_REPEAT;
				if(round(image_index) == image_number) setState("normal");
			break;
		}
	break;
	
	
	default:
		show_message("State not implemented! State: " + state);
		setState("normal");
	break;
}

if(xscale != 1 && xscale != -1) show_message("Scale not in range! \n" + state);

CollideAndMove(mass, 15);