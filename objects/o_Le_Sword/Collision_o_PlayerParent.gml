if(image_index != 1 && other.state != "knight" && other.state != "bomb") {
	o_MusicManager.stopTempSong(); //Just incase...
	other.setState("knight");
	image_index = 1;
	other.playSound(sfx_swordswing);
	o_MusicManager.tempPlaySong(music_knight);
}