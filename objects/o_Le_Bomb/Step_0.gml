time--;
if(time == 50) sprite_index = sprite_level_bomb_lit;
if(time == 0) {
	instance_destroy();
	instance_create_depth(x,y,0,o_Le_BombExplosion);
}
if(PLAYER_TOUCHING_IMAGE) velocity[0] *= -1;
if(PLAYER_GROUNDED) velocity[0] = 0;
CollideAndMove(0.5);