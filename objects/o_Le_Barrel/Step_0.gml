if(PLAYER_GROUNDED) {
	velocity[0] = 0;
	if(place_meeting(x - 5, y, o_PlayerParent) || place_meeting(x + 5, y, o_PlayerParent)) {
		if(o_PlayerParent.state != "mach2" && o_PlayerParent.state != "mach1") return;
		PlaySound(sfx_bump);
		//CreateEffect({sprite_index : sprite_effect_bump}); This is Pre-ETB! There are no effects yet.
		o_PlayerParent.setState("bump");
		o_PlayerParent.velocity[1] = -6;
		velocity = [5 * o_PlayerParent.xscale, -5];
		y--;
	}
}
CollideAndMove(1);