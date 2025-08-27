
sprite_index = asset_get_index("sprite_enemy_" + baseSpriteName + "_" + state);
mask_index = spr_player_mask;

switch(state) {
	
	case "walk":
		velocity[0] = movespeed * image_xscale;
		if(!place_meeting(x + (32*image_xscale), bbox_bottom, o_C_Parent) || place_meeting( (image_xscale == 1 ? bbox_right : bbox_left),y, o_C_Wall) ) image_xscale *= -1;
	break;
	
	case "stun":
		var miniStun = tempVar[0]; //For better readability...
		
		image_speed = miniStun ? 0 : 1;
	
		if(PLAYER_GROUNDED) {
			velocity[0] = 0;
			tempVar[1] += TIME_BASE;
			if(tempVar[1] >= 1 && miniStun || tempVar[1] >= 5 && !miniStun) {
				state = "walk";
				tempVar = [0,0]; //Back to the good ol days, back where I had to program this, or else my game would be unreadable, heh. I love being good ol McPig and his good ol McPig and his good ol McPig and his good ol McPig and his good ol McPig and his good ol McPig and his
				image_speed = 1;
			}
		}
	break;
}
CollideAndMove(mass);