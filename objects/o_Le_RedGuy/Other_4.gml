if(instance_exists(o_PizzaTimeManager)) {
	instance_destroy();
	instance_create_depth(x,y,0,o_P_DeadEnemy, {sprite_index : sprite_level_redguy_dead});
}