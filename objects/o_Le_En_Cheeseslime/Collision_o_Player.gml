if((other.state == PlayerState.Jump && GetInput("jump", 0) || other.state == PlayerState.Freefall) && other.velocity.y > 0) {
	//sprite_index = spriteStun;
	sprite_index = spr_enemy_cheeseslime_bumped;
	if(other.state == PlayerState.Jump) PlaySound(sfx_boing);
	other.tempVar[1] = true;
	other.velocity.y = other.state == PlayerState.Freefall ? -7 : -14;
	tempVar[0] = 200;
}
with(other) {
	//There is another if statement, but it gets replaced by this. HE is so stupiddddddeddddddd
	if(PLAYER_GROUNDED && (PlayerIsMachState(state) || state == PlayerState.Barrel && tempVar[0] == 2) ) {
		other.die(false);
	}
}