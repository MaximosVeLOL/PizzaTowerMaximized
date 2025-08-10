
	with(o_PlayerParent) {
		if(state != "ladder" && string_count(state, "mach") == 0 && state != "knight" && state != "bomb") {
			other.buffer++;
			if( (GetInput("up", 0, PD) && place_meeting(x,y-1,other) || GetInput("down", 0, PD) && place_meeting(x,y+1,other)) && other.buffer >= 20 ) {
				other.buffer = 0;
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
