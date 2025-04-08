with(obj_player) { 
	if(state != "ladder" && (string_count(state, "mach") == 0 && state != "machslide") ) {
		other.buffer++;
		if((GetInput("up") && place_meeting(x,y-1,other) || GetInput("down") && place_meeting(x,y+1,other)) && other.buffer >= 20 ) {
			other.buffer = 0;
			setState("ladder");
			x = other.x + 16;
			y += place_meeting(x,y-1,other) ? -1 : 1;
		}
	}
	if(PLAYER_GROUNDED) buffer = 0;
}