if(image_index != 1 && other.state != "knight" && other.state != "bomb" && global.settings.playerSettings.moveSet != Moveset.PreETB) {
	if(instance_exists(o_MusicManager)) {
		o_MusicManager.stopTempSong(); //Just incase...
		o_MusicManager.tempPlaySong(music_knight);
	}
	other.setState("knight");
	image_index = 1;
	other.playSound(sfx_swordswing);
	
}