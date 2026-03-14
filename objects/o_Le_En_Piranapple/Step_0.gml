if(attack == 0) {
	if(PLAYER_TOUCHING_IMAGE) {
		image_xscale *= -1;
		hspeed *= -1;
	}
}
else {
	attack--;
	if(attack == 0) {
		hspeed = 2 * image_xscale;
		sprite_index = sprite_enemy_piranapple;
	}
}