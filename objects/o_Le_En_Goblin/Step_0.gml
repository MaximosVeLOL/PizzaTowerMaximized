event_inherited();
if(state == "throw") {
	velocity[0] = 0;
	sprite_index = sprite_enemy_goblin_throw;
	SPRITE_NO_REPEAT;
	if(round(image_index) == 3 && !thrown) { //This stops bombs from being thrown multiple times, also because I think this relates to FPS?
		with(instance_create_depth(x,y,0, o_Le_Bomb)) velocity = [5 * image_xscale, -2];
		thrown = true;
	}
	if(PLAYER_GROUNDED && round(image_index) == image_number) setState("idle");
	
}