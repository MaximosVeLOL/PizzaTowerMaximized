switch(state) {
	case "walking":
		sprite_index = spr_enemy_cheeseslime_walk;
		movespeed = 3;
		velocity[0] = movespeed * image_xscale;
		if(place_meeting(x+image_xscale, y, o_C_Wall) || !place_meeting(x + image_xscale, y + 1, o_C_Wall)) {
			image_xscale = -image_xscale;
		}
	break;
	
	case "bumped":
		sprite_index = spr_enemy_cheeseslime_bumped;
		velocity[0] = 0;
		if(round(image_index) == image_number) state = "walking";
	break;
}
if((place_meeting(x+1, y, obj_player) || place_meeting(x-1,y,obj_player)) && (obj_player.state == "mach2" || obj_player.state == "mach3" || obj_player.state == "freefall")) {
	die(spr_enemy_cheeseslime_dead, true);
}
CollideAndMove(0.5, 10);