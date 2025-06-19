switch(state) { //ETB cheeseslimes are very basic in their code, and it is not like the other enemies at ALL.
	case "walk":
		sprite_index = spr_enemy_cheeseslime_walk;
		velocity[0] = 1.5 * image_xscale;
		if(!place_meeting(x + (32 * image_xscale), y + 1, o_C_Parent) || PLAYER_TOUCHING_IMAGE) image_xscale *= -1;
	break;
	
	case "stunned":
		velocity[0] = 0;
		sprite_index = spr_enemy_cheeseslime_bumped;
		if(round(image_index) == image_number) setState("walk");
	break;
}
if((place_meeting(x+1, y, o_PlayerParent) || place_meeting(x-1,y,o_PlayerParent)) && (o_PlayerParent.state == "mach2" || o_PlayerParent.state == "mach3" || o_PlayerParent.state == "freefall")) {
	die(spr_enemy_cheeseslime_dead, true);
}
CollideAndMove(0.5, 10);