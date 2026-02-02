if(PLAYER_GROUNDED) {
	velocity.x = 0;
	if(place_meeting(x - 5, y, o_Player) || place_meeting(x + 5, y, o_Player)) {
		if(o_Player.state != "mach2" && o_Player.state != "mach1") return;
		PlaySound(sfx_bump);
		//CreateEffect({sprite_index : sprite_effect_bump}); This is Pre-ETB! There are no effects yet.
		o_Player.setState("bump");
		o_Player.velocity.y = -6;
		velocity.x = 5 * o_Player.xscale;
		velocity.y = -7;
		y--;
	}
}
CollideAndMove(1);