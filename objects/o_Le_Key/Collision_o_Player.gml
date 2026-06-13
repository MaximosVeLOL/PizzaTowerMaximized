if(global.settings.multiplayer.enabled) {
	GetPlayer(0).inventory.key = true;
}
else other.inventory.key = true;
if(global.settings.player.moveSet != Moveset.PreETB) {
	other.setState(PlayerState.Key);
	o_GameManager.level.toggleTimer();
	audio_pause_all();
	PlaySound(sfx_keyjingle);
	
}
instance_destroy();