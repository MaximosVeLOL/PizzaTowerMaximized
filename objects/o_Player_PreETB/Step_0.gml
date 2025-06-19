var moveX = GetInput("right", 0, PD) - GetInput("left", 0, PD);
var moveY = GetInput("down", 0, PD) - GetInput("up", 0, PD);
if(keyboard_check_pressed(vk_tab)) state = state != "noclip" ? "noclip" : "normal";
switch(state) {
	case "normal":
		velocity[0] = moveX * movespeed;
		if(moveX != xscale) movespeed = 0;
		if(moveX != 0) {
			playSound(sfx_footstep);
			sprite_index = spr_player_move;
			xscale = moveX;
			movespeed = movespeed < 4 ? movespeed + 0.5 : 4;
			image_speed = movespeed / 4;
			tempVar[0] = 0;
		}
		else {
			audio_stop_sound(sfx_footstep);
			tempVar[0]++;
			sprite_index = spr_player_idle;
			
		}
		movespeed = movespeed > 6 ? movespeed - 0.5 : movespeed;
		if(PLAYER_GROUNDED) {
			if(GetInput("jump", 0, PD)) {
				setState("jump");
				CreateEffect({sprite_index : sprite_effect_dust, image_xscale : self.xscale});
				velocity[1] = -9;
			}
			if(GetInput("down", 0, PD)) setState("crouch");
			if(GetInput("dash", 0, PD) && !PLAYER_TOUCHING) setState("mach1");
		}
		else setState("jump");
	break;
	
	case "mach1":
		sprite_index = spr_player_run;
		playSound(sfx_mach1);
		if(moveX != xscale && moveX != 0 || !GetInput("dash", 0, PD) || PLAYER_TOUCHING) {
			setState("normal");
		}
		movespeed += movespeed <= 8 ? 0.2 : 0;
		velocity[0] = round(movespeed * xscale);
		if(PLAYER_GROUNDED) {
			if(GetInput("down", 0, PD)) setState("crouchslide", false);
			tempVar[0]++;
			if(tempVar[0] >= 35) {
				CreateEffect({sprite_index : sprite_effect_dust, image_xscale : xscale});
				setState("mach2", false);
			}	
			if(GetInput("jump", 0, PD)) {
				setState("jump");
				CreateEffect({sprite_index : sprite_effect_dust, image_xscale : self.xscale});
				playSound(sfx_jump);
				velocity[1] = -9;
			}
			if(!instance_exists(o_P_Effect)) {
				CreateEffect({sprite_index : sprite_effect_dashcloud, image_xscale : xscale});
			}
		}
		else setState("jump", false);
		
	break;
	
			case "mach2":
				movespeed = 8;
				velocity[0] = xscale * movespeed;
				if((moveX != xscale && moveX != 0 || !GetInput("dash", 0, PD)) && PLAYER_GROUNDED) {
					setState("machslide");
				}
				
				if(PLAYER_GROUNDED) {
					CreateEffect({sprite_index : sprite_effect_dashcloud, image_xscale : xscale});
					sprite_index = spr_player_run;
					if(GetInput("down", 0, PD)) setState("crouchslide", false);
					playSound(sfx_mach2);
					
					if(GetInput("jump", 1, PD)) velocity[1] = -9;
					if(!GetInput("jump", 0, PD) && velocity[1] < 0) velocity[1] /= 2;
				}
				
				if(PLAYER_TOUCHING) {
					setState("bump");
					playSound(sfx_bump);
					CreateEffect({sprite_index : sprite_effect_bump});
				}
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
					if(GetInput("dash", 0, PD)) {
						setState("mach2", false);
					}
					else setState("normal");
					
					if(place_meeting(x,y-1, o_C_Parent)) setState("bump");
				}
				if(PLAYER_TOUCHING) {
					setState("bump");
					playSound(sfx_bump);
					CreateEffect({sprite_index : sprite_effect_bump});
				}
			break;
			
			case "crouchslide":
				mask_index = spr_player_mask_crouch;
				sprite_index = spr_player_crouchslide;
				velocity[0] = movespeed * xscale;
				movespeed -= 0.2;
				if(!GetInput("down", 0, PD) && tempVar[0] >= 35) {
					setState("mach2", false);
					mask_index = spr_player_mask;
				}
				if(movespeed <= 0) {
					setState("crouch");
				}
				
				if(PLAYER_TOUCHING) {
					setState("bump");
					playSound(sfx_bump);
					CreateEffect({sprite_index : sprite_effect_bump});
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
				if(!GetInput("down", 0, PD) && !place_meeting(x, y - 1, o_C_Parent)) {
					setState("mach3", false);
					mask_index = spr_player_mask;
					tempVar[0] = 35;
				}
				if(!PLAYER_GROUNDED) {
					setState("machfreefall", false);
					mask_index = spr_player_mask;
				}
				if(PLAYER_TOUCHING) {
					setState("bump");
					playSound(sfx_bump);
					CreateEffect({sprite_index : sprite_effect_bump});
					mask_index = spr_player_mask;
					velocity[1] = -3;
				}
			break;
			
			
			case "machfreefall":
				sprite_index = spr_player_mach2jump;
				playSound(sfx_spin);
				velocity[0] = xscale * 10;
				if(PLAYER_GROUNDED && tempVar[0] > 1) {
					if(!GetInput("dash", 0, PD)) { //If we aren't holding the mach 2 button 
						setState("freefall");
						tempVar[0] = 2;
					}
					else {
						setState("mach2", false);
					}
				}
				if(PLAYER_TOUCHING) {
					setState("bump");
					playSound(sfx_bump);
					CreateEffect({sprite_index : sprite_effect_bump});
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
		if(!GetInput("jump", 0, PD) && velocity[1] < 0) velocity[1] /= 2;
		if(round(image_index) == image_number || velocity[1] > 0) sprite_index = spr[1];
		if(GetInput("down", 0, PD)) setState("freefall");
		if(PLAYER_GROUNDED) {
			setState("normal");
			tempVar[1] = true;
		}
	break;
	
	case "bump":
		velocity[0] = -2.5 * xscale;
		sprite_index = spr_player_bump;
		tempVar[0]++;
		if (PLAYER_GROUNDED && velocity[1] >= 0 && tempVar[0] > 10) {
			setState("normal");
			if(place_meeting(x,y - 1, o_C_Parent) || place_meeting(x,y,o_C_Parent)) setState("crouch");
		}
		
	break;
	
	case "noclip":
		sprite_index = spr_player_mach2jump;
		playSound(sfx_spin);
		velocity = [0,0];
		movespeed = GetInput("dash", 0, PD) ? 20 : 10;
		x += moveX * movespeed;
		y += moveY * movespeed;
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
				if(GetInput("dash", 1, PD)) {
					velocity = [0,0];
					if(moveX != 0) xscale = moveX;
					setState("machfreefall", false);
				}
				if(!instance_exists(o_P_Mach3Effect)) {
					instance_create_depth(x,y,0,o_P_Mach3Effect);
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
				if(GetInput("jump", 1, PD) && round(image_index) == image_number) {
					playSound(sfx_jump);
					velocity[1] = -12;
					tempVar[0] = 1;
					image_speed = 1;
				}
				if(!GetInput("up", 0, PD)) setState("normal");
			break;
			
			case 1:
				velocity[0] = movespeed * xscale;
				sprite_index = spr_player_highjump;
				if(moveX != xscale) movespeed = 0;
				if(moveX != 0) {
					xscale = moveX;
					movespeed = movespeed < 4 ? movespeed + 1/2 : 4;
				}
				if(moveY == 1) setState("freefall");
				if(PLAYER_GROUNDED) {
					if(GetInput("up", 0, PD))	{
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
				if(moveX != 0) {
					sprite_index = spr_player_crouch_crawl;
					playSound(sfx_crawl);	
				}
				if(!place_meeting(x,y - 1, o_C_Wall)) {
					if(!GetInput("down", 0, PD)) {
						setState("normal");
						mask_index = spr_player_mask;
					}
					if(GetInput("jump", 1, PD)) {
						animVar = false;
						tempVar[0] = 1;
						playSound(sfx_jump);
						CreateEffect({sprite_index : sprite_effect_dust, image_xscale : self.xscale});
						velocity[1] = -8;
						mask_index = spr_player_mask;	
					}
				}
			break;
			
			case 1:
				mask_index = spr_player_mask_crouch;
				if(!animVar) {
					sprite_index = spr_player_crouch_jumping;
					if(round(image_index) == image_number || velocity[1] > 0) animVar = true;
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
			playSound(sfx_facestomp);
			CreateEffect({sprite_index : sprite_effect_landcloud});
			playSound(sfx_land);
		}
		switch(tempVar[0]) {
			case 0:
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
				
				if(!GetInput("down", 0, PD)) setState("jump");
				tempVar[1]++;
				if(tempVar[1] >= 30) {
					tempVar[0] = 1;
					tempVar[1] = 0;	
				}
				//animVar = broke a breakable
				if(!animVar) sprite_index = spr_player_freefall_prep;
				else {
					sprite_index = spr_player_freefall_prep_hit;
					SPRITE_NO_REPEAT;
					if(round(image_index) == image_number) animVar = true;
				}
				
			break;
			
			case 1:
				sprite_index = spr_player_freefalling;
				velocity[0] = 0;
				tempVar[1]++;
				if(tempVar[1] > 15) setState("superslam"); //Change - 30 to 15
				if(GetInput("dash", 0, PD)) setState("mach2");
			break;
			
			case 2:
				sprite_index = spr_player_freefall_impact;
				SPRITE_NO_REPEAT;
				if(round(image_index) == image_number) {
					if(tempVar[1] > 30) {
						setState("machfreefall");
						velocity[1] = -7;
					}
					else setState("normal");
				}
			break;
		}
	break;
	
	case "superslam":
		sprite_index = spr_player_freefalling;
		if(PLAYER_GROUNDED) {
			playSound(sfx_superimpact);
			setState("freefall");
			tempVar[0] = 2;
			tempVar[1] = 31;
			ShakeScreen(10);
			with(o_Le_En_Parent) {
				if(point_in_rectangle(x,y,camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]), camera_get_view_x(view_camera[0]) + 960, camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) )) {
					setState("stunned");
					velocity[1] = -7;
					velocity[0] = 0;
					tempVar[0] = 200;
				}
			}
			CreateEffect({y : self.y + 12, sprite_index : sprite_effect_meteor, image_alpha : 270});
		}
	break;
	
	case "ladder":
		mass = 0;
		velocity[0] = 0;
		if(!place_meeting(x,y, o_Le_Ladder) || PLAYER_GROUNDED) setState("normal");
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
		if(GetInput("jump", 1, PD)) {
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
				image_speed = 1;
				sprite_index = spr_player_door_out;
				SPRITE_NO_REPEAT;
				if(round(image_index) == image_number) setState("normal");
			break;
		}
	break;
	
	case "enemy":
		switch(tempVar[0]) {
			case 0: //Holding him
				velocity[0] = moveX * movespeed;
				if(moveX != xscale) movespeed = 0;
				if(moveX != 0) {
					xscale = moveX;
					if(PLAYER_GROUNDED) sprite_index = spr_player_grabbing_move; //I hate animations!
					movespeed = movespeed < 6 ? movespeed + 0.5 : 6;
					image_speed = movespeed/6;
				}
				else if(PLAYER_GROUNDED) sprite_index = spr_player_grabbing; //We have to make a duplicate if statement here
				
				if(PLAYER_GROUNDED) {
					if(GetInput("dash", 0, PD)) {
						tempVar[0] = 1;
					}
					if(GetInput("jump", 0, PD)) {
						playSound(sfx_jump);
						velocity[1] = -9;
						sprite_index = spr_player_grabbing_jump;
						image_index = 0;
					}
				}
				else {
					if(round(image_index) == image_number) {
						sprite_index = spr_player_grabbing_fall;
						image_index = 0;
					}
					if(!GetInput("jump", 0, PD) && velocity[1] < 0) velocity[1] /= 2;
					
					if(GetInput("dash", 0, PD)) {
						tempVar[0] = 1;
					}
					if(GetInput("jump", 1, PD)) {
						velocity[1] = -9;
						tempVar[0] = 3;
					}
				}
					
			break;
			
			case 1: //Charging
				xscale = 1;
				velocity[0] = 0;
				if(tempVar[1] < 20) {
					tempVar[1]++;
					image_speed = 0;
				}
				else {
					image_speed = 1; //There used to be no FPS option in GM1, so 0.35 * (roomspeed) = 21
					playSound(sfx_superdash);
				}
				if(moveX == 1) sprite_index = spr_player_grabbing_punchprep;
				else if(moveX == -1) sprite_index = spr_player_grabbing_backkickprep;
				else sprite_index = spr_player_grabbing_charge;
				
				//There are issues with keyboard_check_released not being valid in the first frames of the state!
				//TODO - Fact check
				//Yea its true, but only if theres other conditions
				if(GetInput("dash", 2, PD)) {
					switch(sprite_index) { //TODO - Find a better way?
						case spr_player_grabbing_charge:
							playSound(sfx_woosh);
							if(tempVar[1] < 20) {
								with(tempVar[2]) {
									velocity[0] = other.xscale * 7;
									velocity[1] = -8;
								}
							}
							else {
								with(tempVar[2]) {
									velocity[0] = other.xscale * 10;
									velocity[1] = -12;
								}
							}
							sprite_index = spr_player_grabbing_throw;
						break;
						
						case spr_player_grabbing_punchprep:
							playSound(sfx_woosh);
							if(tempVar[1] < 20) {
								with(tempVar[2]) {
									velocity[0] = other.xscale * 7;
									velocity[1] = -4;
								}
							}
							else {
								with(tempVar[2]) {
									velocity[0] = other.xscale * 20;
									setState("fly");
								}
							}
							sprite_index = spr_player_grabbing_punch;
						break;
						
						case spr_player_grabbing_backkickprep:
							playSound(sfx_woosh);
							if(tempVar[1] < 20) {
								with(tempVar[2]) {
									velocity[0] = other.xscale * -5;
									velocity[1] = -4;
								}
							}
							else {
								with(tempVar[2]) {
									velocity[0] = other.xscale * -20;
									setState("fly");
								}
							}
							sprite_index = spr_player_grabbing_backkick;
						break;
					}
					image_index = 0;
					image_speed = 1;
					CreateEffect({x : self.x + (self.xscale * 10), sprite_index : sprite_effect_bang});
					if(tempVar[2].state != "fly") tempVar[2].setState("hit");
					tempVar[0] = 2;
				}
				
			break;
			
			case 2: //Throwing
				if(PLAYER_GROUNDED) velocity[0] = 0;
				SPRITE_NO_REPEAT;
				if(round(image_index) == image_number) setState("normal");
			break;
		}
	break;
	
	case "key":
		velocity = [0,0];
		mass = 0;
		sprite_index = spr_player_keyget;
		SPRITE_NO_REPEAT;
		if(round(image_index) == 17) playSound(choose(va_happy1, va_happy2, va_happy3));
		if(round(image_index) == image_number) {
			audio_resume_all();
			setState("normal");
		}
	break;
	
	case "knight":
		switch(tempVar[0]) {
			case 0: //Start
				velocity[0] = 0;
				
				if(!animVar) {
					sprite_index = spr_player_knight_start;
					if(round(image_index) == 9) instance_create_depth(x,y-600, 0, o_P_KnightEffect);
					if(round(image_index) == image_number) animVar = true;
				}
				else {
					sprite_index = spr_player_knight_thunder;
					if(round(image_index) == image_number) tempVar[0] = 1;
				}
			break;
			
			case 1: //Normal Knight
				velocity[0] = moveX * movespeed;
				if(moveX != xscale) movespeed = 0;
				if(moveX != 0) {
					sprite_index = spr_player_knight_walk;
					xscale = moveX;
					movespeed = movespeed < 4 ? movespeed + 0.1 : 4;
				}
				else if(!animVar) sprite_index = spr_player_knight_idle;
				if(animVar) sprite_index = spr_player_knight_land;
				//Jump handling
				if(GetInput("jump", 0, PD) && sprite_index != spr_player_knight_jumpprep) sprite_index = spr_player_knight_jumpprep;
				if(round(image_index) == image_number) {
					if(sprite_index == spr_player_knight_jumpprep) {
						velocity[0] = moveX * 4;
						playSound(sfx_jump);
						velocity[1] = -7;
						tempVar[0] = 2;
						image_index = 0;
					}
					if(animVar) animVar = false;
				}
				else if(sprite_index == spr_player_knight_jumpprep) velocity[0] = 0;
				if(GetInput("dash", 1, PD)) {
					playSound(sfx_swordswing);
					CreateEffect({x : self.x + (xscale * 10), sprite_index : sprite_effect_dashcloud}); //Hehehe this is not slidecloud, its dashcloud
					tempVar[0] = 3;
					with(instance_create_depth(x,y,0,o_H_Sword, {image_xscale : xscale})) PD = other.PD;
					image_index = 0;
				}
				
				if(!PLAYER_GROUNDED) tempVar[0] = 2;
			break;
			
			case 2: //Jump
				if(!animVar) {
					sprite_index = spr_player_knight_jump;
					if(round(image_index) == image_number) animVar = true;
				}
				else sprite_index = spr_player_knight_fall;
				if(PLAYER_GROUNDED && sprite_index == spr_player_knight_fall) {
					animVar = true;
					tempVar[0] = 1;
					image_index = 0;
					movespeed = 0;
				}
			break;
			
			case 3: //Attack
				sprite_index = spr_player_knight_attack;
				velocity[0] = movespeed * xscale;
				movespeed = movespeed > 0 ? movespeed - 0.2 : 0;
				if(round(image_index) == image_number) {
					tempVar[0] = 1;
					image_index = 0;
					instance_destroy(o_H_Sword);
				}
			break;
		}
	break;
	
	case "stunned":
		sprite_index = spr_player_hurt;
		if(PLAYER_GROUNDED) {
			velocity[1] = -5 + (tempVar[0] * 2);
			tempVar[0]++;
			velocity[0] = tempVar[0] < 2 ? 3 * xscale : 0;
			if(round(image_index) == image_number) {
				setState("normal");
				stunStuff.invincibleFrames = 20;
			}
			if(tempVar[1] != 0) {
				tempVar[1]--;
				with(instance_create_depth(x,y,0,o_Le_Points)) {
					isStatic = false;
					velocity = [other.image_xscale * random_range(3, 5), random_range(-3, -10)]
				}
			}
		}
		if(PLAYER_TOUCHING) xscale *= -1;
	break;
	
	case "bomb":
		switch(tempVar[0]) {
			case 0: //Picks it up
				velocity[0] = 0;
				sprite_index = spr_player_bomb_start;
				if(round(image_index) == image_number) {
					tempVar[0] = 1;
				}
			break;
			
			case 1:
				sprite_index = tempVar[2] ? spr_player_bomb_edge : spr_player_bomb_run;
				velocity[0] = round(movespeed * xscale);
				movespeed = movespeed < 8 ? movespeed + 0.2 : 8;
				if(PLAYER_TOUCHING) {
					if(tempVar[1] == 1) tempVar[2] = true;
					if(tempVar[1] == 2) tempVar[0] = 3;
					playSound(sfx_bump);
					CreateEffect({sprite_index : sprite_effect_bump});
					xscale *= -1;
					tempVar[1]++;
				}
				if(GetInput("jump", 1, PD) && PLAYER_GROUNDED) velocity[1] = -9;
			break;
			
			case 2:
				sprite_index = spr_player_bomb_explode;
				SPRITE_NO_REPEAT;
				if(round(image_index) == image_number) {
					setState("normal");
					stunStuff.invincibleFrames = 200;
				}
			break;
			
			case 3:
				o_MusicManager.stopTempSong();
				if(!instance_exists(o_Le_BombExplosion))instance_create_depth(x,y,0,o_Le_BombExplosion);
				tempVar[0] = 2;
			break;
		}
	break;
	
	
	default:
		show_message("State not implemented! State: " + state);
		setState("normal");
	break;
}
if(stunStuff.invincibleFrames > 0 && state != "stunned") {
	stunStuff.invincibleFrames--;
	stunStuff.flashing = !stunStuff.flashing;
}
if(xscale != 1 && xscale != -1) show_message("Scale not in range! \n" + state);

CollideAndMove(mass, 30);