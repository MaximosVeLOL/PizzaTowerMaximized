velocity = [0,0];
movespeed = 1.5;
mass = 0.5;
state = "walk";
spriteBaseName = "";
tempVar = [0,0];
die = function() {
	instance_destroy();
	instance_create_depth(x,y,0,o_P_Effect, {sprite_index : asset_get_index("sprite_enemy_" + baseSpriteName + "_" + state) });
}