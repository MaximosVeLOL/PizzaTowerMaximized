with(other) { //The player we are colliding with
	if(bbox_top <= other.bbox_top || xscale != other.image_xscale && !other.goUp) return;
	var isMach = (string_count("mach", state) > 0);
	if(other.goUp) {
		if(state == "jump" || state == "highJump" || isMach) {
			setState("transition", false); //We need to check if the player is mach running
			other.hooked = true; //us
			other.vspeed = -10;
			sprite_index = spr_player_hook;
		}
	}
	//Remove the mach 1 check, because when you jump in mach1, you get set to the jump state.settings.. smh McPig
	else if(isMach || (state == "jump" || state == "highjump") && velocity.x != 0) {
		other.hooked = true; //us
		
		other.hspeed = 10 * other.image_xscale; //us
		sprite_index = (isMach ? spr_player_hook_slide : spr_player_hook);
		
		setState("transition", false); //We need to check if the player is mach running
	}
	other.plrGoFast = isMach;
}
plr = other;

