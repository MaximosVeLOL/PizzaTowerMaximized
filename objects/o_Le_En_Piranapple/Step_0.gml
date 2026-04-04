if(attack == 0) {
	if(place_meeting(x + image_xscale, y, o_C_Wall)) {
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