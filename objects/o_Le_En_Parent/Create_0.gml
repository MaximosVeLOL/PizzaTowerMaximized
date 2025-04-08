movespeed = 0;
state = "";
velocity = [0,0];


die = function(dead_sprite, isStatic = true) {
	instance_destroy();
	if(isStatic) instance_create_depth(x,y,0,o_P_Effect, {sprite_index : dead_sprite});
	else instance_create_depth(x,y,0,o_P_DeadEnemy, {sprite_index : dead_sprite});
}