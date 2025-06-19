for(var i = 0 ; i < instance_number(o_PlayerParent);i++) {
	with(instance_find(o_PlayerParent, i)) {
		if(state != "ladder" && string_count(state, "mach") == 0 && state != "knight" && state != "bomb") {
			other.buffer++;
			if( (GetInput("up") && place_meeting(x,y-1,other) || GetInput("down") && place_meeting(x,y+1,other)) && other.buffer >= 20 ) {
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
}