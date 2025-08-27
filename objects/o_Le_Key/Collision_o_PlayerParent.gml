other.inventory.key = true;
if(global.settings.playerSettings.moveSet != Moveset.PreETB) {
	other.setState("key");
	audio_pause_all();
	PlaySound(sfx_keyjingle);
	
}
instance_destroy();