with(other) {
	if( (string_count("mach", state) > 0 && state != "mach1" || state == "jump" ) && bbox_top > other.bbox_top) {
		setState("transition", false); //We need to check if the player is mach running
		other.hooked = true;
		other.hspeed = 10;
	}

	
}

