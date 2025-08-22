event_inherited();
baseSpriteName = "forknight";
child = instance_create_depth(x,y,0,o_H_Fork);

die = function() {
	instance_destroy(child);
	instance_destroy();
	
	instance_create_depth(x,y, 0, o_P_DeadEnemy, {sprite_index : sprite_enemy_forknight_dead});
}