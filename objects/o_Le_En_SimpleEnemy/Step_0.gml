
sprite_index = asset_get_index(spriteBaseName + "_" + state);
switch(state) {
	
	case "walk":
		velocity[0] = movespeed * image_xscale;
		if(!place_meeting(x + 32, bbox_bottom, o_C_Parent) || place_meeting(x+1,y, o_C_Wall) ) image_xscale *= -1;
	break;
	
	case "stun":
		
		
	break;
}