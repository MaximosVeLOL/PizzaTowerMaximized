if(fadeAlpha < 1) {
	fadeAlpha += 0.1;
}
if(sprite_index == sprite_hud_rank_trans) {
	if(IMAGE_COMPLETE) sprite_index = rankSprites[clamp(floor(o_GameManager.level.score / 500), 1, 6) - 1]; //I am so unbelievable

}
else {
	if(!audio_is_playing(rankMusic) && keyboard_check(vk_anykey)) {
        texturegroup_unload("tgRank");
		o_GameManager.goToHub();
        instance_destroy();
	}
}
SPRITE_NO_REPEAT;