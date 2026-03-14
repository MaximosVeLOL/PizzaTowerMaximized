with(other) {
	if(bbox_top <= other.bbox_top || xscale != other.image_xscale) return;
	if(other.goUp) {
		if(state == "jump" || state == "highJump") {
			setState("transition", false); //We need to check if the player is mach running
			other.hooked = true; //us
			other.vspeed = -10;
			sprite_index = spr_player_hook;
		}
	}
	else if( (string_count("mach", state) > 0 && state != "mach1" || state == "jump" || state == "highjump" )) {
		setState("transition", false); //We need to check if the player is mach running
		other.hooked = true; //us
		other.hspeed = 10 * other.image_xscale; //us
		
		sprite_index = spr_player_hook_slide;
	}
}
plr = other;

