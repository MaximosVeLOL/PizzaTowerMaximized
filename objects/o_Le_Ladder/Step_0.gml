ForEachPlayer(function(i, plr) {
	with(plr) {
		if(state != PlayerState.Ladder && string_count("mach", state) == 0 && state != PlayerState.Knight && state != PlayerState.Bomb && state != PlayerState.Bump && state != PlayerState.Hurt) {
			other.buffer[i]++;
			if( (GetInput("up", 0, playerID) && place_meeting(x,y-1,other) || GetInput("down", 0, playerID) && place_meeting(x,y+1,other)) && other.buffer[i] >= 20 ) {
				other.buffer[i] = 0;
				setState(PlayerState.Ladder);
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