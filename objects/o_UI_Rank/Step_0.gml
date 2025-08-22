if(fadeAlpha < 1) {
	fadeAlpha += 0.1;
}
if(sprite_index == sprite_hud_rank_trans) {
	if(IMAGE_COMPLETE) sprite_index = rankSprites[clamp(floor(score / 500), 1, 6) - 1]; //I am so unbelievable

}
else {
	if(!audio_is_playing(rankMusic) && keyboard_check(vk_anykey)) {
		instance_destroy();
		o_GameManager.goToHub();
	}
}
SPRITE_NO_REPEAT;