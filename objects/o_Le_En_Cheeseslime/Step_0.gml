/*
	switch(state) { //ETB cheeseslimes are very basic in their code, and it is not like the other enemies at ALL.
	case "walk":
		sprite_index = spr_enemy_cheeseslime_walk;
		velocity.x = 1.5 * image_xscale;
		if(!place_meeting(x + (32 * image_xscale), y + 1, o_C_Parent) || PLAYER_TOUCHING_IMAGE) image_xscale *= -1;
	break;
	
	case "stunned":
		velocity.x = 0;
		sprite_index = spr_enemy_cheeseslime_bumped;
		if(IMAGE_COMPLETE) setState("walk");
	break;
}
*/
event_inherited();
if((place_meeting(x+1, y, o_Player) || place_meeting(x-1,y,o_Player)) && (o_Player.state == PlayerState.Mach2 || o_Player.state == PlayerState.Mach3 || o_Player.state == PlayerState.Freefall)) {
	die(false);
}
CollideAndMove(0.5, 10);