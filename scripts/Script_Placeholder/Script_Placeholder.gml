/*
case Moveset.PreETB:
			switch(state) {
	
				case "normal":
					velocity.x = moveX * movespeed;
					switch(tempVar[0]) {
						case 0: //walking
							if(moveX != 0) {
								playSound(sfx_footstep);
								image_speed = movespeed / 4;
								sprite_index = spr_player_move;
								movespeed = movespeed < 4 ? movespeed + 0.5 : 4;
								if(moveX != xscale) {
									tempVar[0] = 1;
									image_speed = 1;
									image_index = 0;
								}
							}
							else {
								movespeed = 0;
								sprite_index = spr_player_idle;
							}
								if(GetInput("dash", 0, playerID) && !PLAYER_TOUCHING) {
									setState("mach1", true, true);
								}
							if(GetInput("jump", 1, playerID)) {
								setState("jump");
								playSound(sfx_jump);
								velocity.y = -9;
							}

							if(!PLAYER_GROUNDED) setState("jump");
							if(GetInput("down", 1, playerID)) {
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
					if(moveX != xscale) {
						tempVar[0] = 0;
						movespeed = 0;
					}
					var spr = [spr_player_jump, spr_player_fall];
			
					if(moveX != 0) {
						spr = [spr_player_jump_moving, spr_player_fall_moving];
						xscale = moveX;
					}

					if(tempVar[2] == 0 && !animVar && velocity.y < 0) {
						playSound(sfx_jump);
						sprite_index = spr[0];
						animVar = true;
					}
		
					movespeed = movespeed < 6 ? movespeed + 0.5 : 6;
					velocity.x = moveX * movespeed;
					if(!GetInput("jump", 0, playerID) && velocity.y < 0) velocity.y /= 2;
					if((round(image_index) == image_number || velocity.y > 0) && tempVar[2] == 0) sprite_index = spr[1];
					if(GetInput("down", 0, playerID)) {
						setState("freefall");
						tempVar[0] = 3;
						if(velocity.y < 0) velocity.y = 0;
					}
					if(PLAYER_GROUNDED) {
						if(GetInput("dash", 0, playerID))
							setState("mach1", false);
						else {
							setState("normal");
							tempVar[1] = true;
						}
					}
					
					//Hacky?
					if(tempVar[2] != 0) {
						if(tempVar[2] != 2) {
							sprite_index = spr_player_stomp_prep;
							if(IMAGE_COMPLETE) tempVar[2] = 2;
						}
						else sprite_index = spr_player_stomp;
					}
				break;
	
				case "mach1":
					CreateEffect({sprite_index : sprite_effect_dashcloud, image_xscale : self.xscale});
					velocity.x = movespeed * xscale;
					movespeed += 0.2;
					sprite_index = spr_player_run;
					tempVar[0]++;
					playSound(sfx_mach1);
					if(GetInput("dash", 2, playerID) || moveX != xscale && moveX != 0 || PLAYER_TOUCHING) {
						if(moveX != 0 ) xscale = moveX;
						setState("normal");
					}
					if(tempVar[0] >= 35) {
						setState("mach2");
					}
				break;
	
				case "mach2":
					image_speed = 2;
		
		
					velocity.x = movespeed * xscale;
					movespeed = 10;
					if(tempVar[1] == 0) {
						tempVar[1] = 6;
						instance_create_depth(x,y,0,o_P_Mach3Effect);
					}
					tempVar[1]--;
					if(PLAYER_GROUNDED) {
						CreateEffect({sprite_index : sprite_effect_dashcloud, image_xscale : self.xscale});
						playSound(sfx_mach2);
						if(GetInput("jump", 1, playerID)) {
							velocity.y = -9;
						} 
								if(global.settings.player.PreETB_betterRunning && (GetInput("dash", 2, playerID) || moveX != xscale && moveX != 0) ) setState("CUSTOMmachSlide");

					}
					else if(GetInput("jump", 2) && velocity.y < 0) velocity.y /= 2;
		
		
					if(PLAYER_TOUCHING) {
						setState("bump");
						PlaySound(sfx_bump);
						ShakeCamera(10, 1/2);
						velocity.y = -6;
					}
					sprite_index = spr_player_run;
				break;
	
				case "CUSTOMmachSlide": //This looks very similar to the slip state.settings..
					velocity.x = movespeed * xscale;
					sprite_index = animVar ? spr_player_machslide : spr_player_machslide_start;
					if(IMAGE_COMPLETE && !animVar) animVar = true;
					movespeed -= 0.2;
					if(PLAYER_TOUCHING) {
						setState("bump");
						PlaySound(sfx_bump);
						velocity.y = -3;
					}
					if(movespeed <= 0) {
						if(moveX != xscale && moveX != 0 && GetInput("dash", playerID)) {
							xscale = moveX;
							setState("mach1");
						}
						else setState("normal");
					}
		
				break;
	
				case "bump":
		
					velocity.x = movespeed * xscale;
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
							velocity.x = 0;
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
						velocity.y = -5 + (tempVar[0] * 2);
						tempVar[0]++;
					}
					velocity.x = tempVar[0] < 2 ? 3 * xscale : 0;
					if(round(image_index) == image_number) {
						setState("normal");
						stunStuff.invincibleFrames = 200;
					}
					if(tempVar[1] != 0 || global.settings.gameplay.goonerMode) {
						tempVar[1]--;
						o_GameManager.level.score -= 10;
						with(instance_create_depth(x,y,0,o_Le_Points)) {
							canMove = true;
							velocity.x = other.image_xscale * random_range(3, 5);
							velocity.y = random_range(-3, -10);
						}
					}
					if(PLAYER_TOUCHING) xscale *= -1;
				break;
	
				case "ladder":
					mass = 0;
					velocity.x = 0;
					tempVar[1]++;
					if((!place_meeting(x,y, o_Le_Ladder) || PLAYER_GROUNDED) && tempVar[1] > 10) setState("normal");
					switch(moveY) {
						case -1: //Up
							velocity.y = -2;
							sprite_index = spr_player_ladderup
							playSound(sfx_climb);			
						break;
			
						case 1:
							velocity.y = 6;
							sprite_index = spr_player_ladderdown;			
						break;
			
						case 0:
							velocity.y = 0;
							sprite_index = spr_player_ladder;
						break;
					}
					if(GetInput("jump", 1, playerID)) {
						setState("jump", );
						playSound(sfx_jump);
						velocity.y = -9;
					}
				break;
	
	
				case "crouch":
					mask_index = spr_player_mask_crouch;
					velocity.x = movespeed * xscale;
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
								if(animVar) sprite_index = spr_player_crouch_crawl;
								playSound(sfx_crawl);	
							}
							if(!place_meeting(x,y - 1, o_C_Wall)) {
								if(!GetInput("down", 0, playerID)) {
									setState("normal");
									mask_index = spr_player_mask;
								}
								if(GetInput("jump", 1, playerID)) {
									animVar = false;
									tempVar[0] = 1;
									playSound(sfx_jump);
									CreateEffect({sprite_index : sprite_effect_dust, image_xscale : o_Player.xscale});
									velocity.y = -8;
									mask_index = spr_player_mask;	
								}
							}
							if(!PLAYER_GROUNDED) tempVar[0] = 1;
						break;
			
						case 1:
							mask_index = spr_player_mask_crouch;
							if(!animVar) {
								sprite_index = spr_player_crouch_jumping;
								if(round(image_index) == image_number || velocity.y > 0) animVar = true;
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
					velocity.x = 0;
					switch(tempVar[0]) {
						case 0:
							tempVar[0] = 1; //For the other stuff, as in the metal blocks, and enemies.
						break;
			
						case 1:
							sprite_index = spr_player_freefalling;
							velocity.y++;
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
							velocity.x = 0;
							velocity.y = 0;
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
	
				case "noclip":
					movespeed = GetInput("dash", 0, playerID) ? 20 : 10;
					x += moveX * movespeed;
					y += moveY * movespeed;
					return;
				break;
	
				case "transition":
					return;
				break;
	
	
				case "slip":
					image_speed = 1;
					if(sprite_index != spr_player_slip) 
						sprite_index = spr_player_slip;
					playSound(sfx_slide);
					velocity.x = movespeed * xscale;
					movespeed -= 0.2;
					if(movespeed <= 0) setState("normal");
					if(PLAYER_TOUCHING) {
						setState("bump");
					}
				break;
	
				default:
					show_message("State not implemented! State: " + state);
					setState("normal");
				break;
				
				
				case "barrel":
					var touchingWater = place_meeting(x, y - 23, o_Le_Water);
					switch(tempVar[0]) {
						case 0: //Normal
							if(moveX != 0) {
								sprite_index = spr_player_barrel_move;
								xscale = moveX;
							}
							else sprite_index = spr_player_barrel_idle;
							velocity.x = moveX * 2.5;
							if(GetInput("dash", 0, playerID)) {
								tempVar[0] = 1;
							}
							if(GetInput("down", 1, playerID)) {
								tempVar[0] = 5;
								image_index = 0;
							}
							if(!PLAYER_GROUNDED) tempVar[0] = 4;
						break;
						
						case 1: //Dashing
							playSound(sfx_mach1);
							sprite_index = spr_player_barrel_mach;
							tempVar[1]++;
							movespeed = (movespeed < 8 ? movespeed + 0.2 : 8);
							if(tempVar[1] >= 35) {
								tempVar[1] = 0;
								tempVar[0] = 2;
								movespeed = 0;
								sprite_index = spr_player_barrel_rollS;
								mask_index = spr_player_mask_crouch;
							}
							velocity.x = xscale * movespeed;
							
							if(PLAYER_TOUCHING || moveX != 0 && moveX != xscale || !GetInput("dash", 0, playerID)) {
								tempVar[1] = 0;
								tempVar[0] = 0;
								movespeed = 0;
							}
							if(!PLAYER_GROUNDED) {
								tempVar[1] = 0;
								tempVar[0] = 4;
								movespeed = 0;
							}
							
							CreateEffect({sprite_index : sprite_effect_dashcloud, image_xscale : xscale});
						break;
						
						case 2: //Rolling
							playSound(sfx_superdash);
							if(sprite_index == spr_player_barrel_rollS && IMAGE_COMPLETE) sprite_index = spr_player_barrel_roll;
							velocity.x = 10 * xscale;
							tempVar[1] = (PLAYER_GROUNDED ? 0 : tempVar[1] + 1);
							if(GetInput("jump", 1, playerID) && tempVar[1] < 8) {
								velocity.y = -8;
							}
							if(!GetInput("jump", 0, playerID) && velocity.y < 0) {
								velocity.y /= 2;
							}
							else instance_create(x, y, o_P_MachEffect);
							if(PLAYER_TOUCHING) {
								setState("bump");
								velocity.x = xscale * -3;
								velocity.y = -5;
								
								CreateEffect({sprite_index : sprite_effect_bump});
								repeat(15) {
									instance_create_depth(x+random_range(-15, 15),y+random_range(-15, 15), 0, o_P_Breakable, {sprite_index : spr_breakabledoor_broken});
								}
								PlaySound(sound_barrelhit);
								PlaySound(sfx_bump);
								o_Le_Barrel.Activate();
								instance_destroy(o_P_MachEffect);
							}
						break;
						
						case 3: //Floating
							sprite_index = spr_player_barrel_float;
							if(moveX != 0) xscale = moveX;
							velocity.x = moveX * 2.5; 
							if(touchingWater) velocity.y = -1;
							if(GetInput("jump", 1, playerID)) {
								setState("jump");
								//Whatever the base velocity is for the water stuff, put it here!!!
								velocity.y = -9 * 1.25;
								PlaySound(sound_splash, true);
								instance_create(x, y, o_Le_BarrelFloat);
							}
						break;
						
						case 4: //Falling
							sprite_index = spr_player_barrel_fall;
							velocity.x = 0;
							if(touchingWater) {
								tempVar[0] = 3;
								velocity.y -= 0.5;
								//y += 32;
							}
							else if(PLAYER_GROUNDED) {
								tempVar[0] = 0;
								tempVar[1] = 0;
								movespeed = 0;
							}
						break;
						
						case 5: //Crouching
							sprite_index = spr_player_barrel_crouch;
							velocity.x = 0;
							SPRITE_NO_REPEAT;
							if(!GetInput("down", 0, playerID)) {
								tempVar[0] = 0;
								image_speed = 1;
							}
						break;
					}
				break;
				
				case "hump": //Such a simple state.
					sprite_index = spr_player_hump;
					SPRITE_NO_REPEAT;
					if(IMAGE_COMPLETE) setState("normal");
				break;
			}
		break;
*/