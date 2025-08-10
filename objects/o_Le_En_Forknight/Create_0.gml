event_inherited();
baseSpriteName = "forknight";
instance_create_depth(x,y,0,o_H_Fork);
die = function() {
	instance_destroy();
	instance_create_depth(x,y, o_P_DeadEnemy, {sprite_index : sprite_enemy_forknight_dead});
}