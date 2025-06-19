if((other.state == "jump" && GetInput("jump", 0, other.PD) || other.state == "freefall") && other.velocity[1] > 0) {
	setState("stunned");
	sprite_index = spr_enemy_cheeseslime_bumped;
	if(other.state == "jump") PlaySound(sfx_boing);
	other.tempVar[1] = true;
	other.velocity[1] = other.state == "freefall" ? -7 : -14;
	tempVar[0] = 200;
}
with(other) {
	//There is another if statement, but it gets replaced by this. HE is so stupiddddddeddddddd
	if(other.state != "hitspecial" && PLAYER_GROUNDED && (string_count("mach", state) || state == "something") ) {
		other.die(spr_enemy_cheeseslime_dead, true);
	}
}