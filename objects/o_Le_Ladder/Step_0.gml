ForEachPlayer(function(i, plr) {
	with(plr) {
		if(state != "ladder" && string_count("mach", state) == 0 && state != "knight" && state != "bomb" && state != "bump" && state != "hurt") {
			other.buffer[i]++;
			if( (GetInput("up", 0, playerID) && place_meeting(x,y-1,other) || GetInput("down", 0, playerID) && place_meeting(x,y+1,other)) && other.buffer[i] >= 20 ) {
				other.buffer[i] = 0;
				setState("ladder");
				x = other.x + 16;
				y += sign(other.y - y);
				if(place_meeting(x,bbox_bottom, o_C_Platform)) {
					with(instance_place(x,bbox_bottom, o_C_Wall)) instance_destroy();
				}
			}
		}
		if(PLAYER_GROUNDED) buffer = 0;
	}
});