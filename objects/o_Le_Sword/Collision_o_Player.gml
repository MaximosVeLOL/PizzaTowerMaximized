//TODO- Add transformation checks
if(image_index != 1 && other.state != PlayerState.Knight && other.state != PlayerState.Bomb && global.settings.player.moveSet != Moveset.PreETB) {
	if(instance_exists(o_MusicManager)) {
		o_MusicManager.stopTempSong(); //Just incase.settings..
		o_MusicManager.tempPlaySong(music_knight);
	}
	other.setState(PlayerState.Knight);
	image_index = 1;
	other.playSound(sfx_swordswing);
	
}