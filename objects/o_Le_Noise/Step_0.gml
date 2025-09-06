if(x != o_Le_NoiseSpawn.x + 16) {
	hspeed = 2 * image_xscale;
	sprite_index = sprite_level_noise_walk;
	CreateEffect({y : bbox_bottom, sprite_index : sprite_effect_cloud});
}
else {
	hspeed = 0;
	sprite_index = sprite_level_noise_button;
	if(round(image_index) == 54 && !instance_exists(o_PizzaTimeManager)) {
		instance_create_depth(0,0,0,o_PizzaTimeManager);
		o_PlayerParent.sprite_index = spr_player_treasure_scream;
		o_PlayerParent.image_speed = 1;
	}
	if(round(image_index) == image_number) {
		x += image_xscale; //Shift by a little bit to disturb our fellow x check
		image_xscale = -image_xscale; // *= -1 or -image_xscale, comment which one?
	}
}