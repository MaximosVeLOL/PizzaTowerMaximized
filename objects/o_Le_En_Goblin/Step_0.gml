if(state == EnemyState.Custom) {
	velocity.x = 0;
	sprite_index = sprite_enemy_goblin_throw;
	SPRITE_NO_REPEAT;
	if(floor(image_index) == 3 && !thrown) { //This stops bombs from being thrown multiple times, also because I think this relates to FPS?
		with(instance_create_depth(x,y,0, o_Le_Bomb)) {
			velocity.x = 5 * image_xscale;
			velocity.y = -2;
		
		}
		thrown = true;
	}
	if(PLAYER_GROUNDED && IMAGE_COMPLETE) {
		setState(EnemyState.Idle);
		thrown = false;
	}
	return;
}
event_inherited();