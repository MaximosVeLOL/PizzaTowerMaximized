paused = false;

if(instance_exists(o_MusicManager)) {
	o_MusicManager.stopMusic(true);
	o_MusicManager.stopTempSong();
	o_MusicManager.playNewSong(music_pizzatime);
}

instance_destroy(o_Le_RedGuy);