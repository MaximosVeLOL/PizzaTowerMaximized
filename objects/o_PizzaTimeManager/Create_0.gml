//TODO - Either remove the pause feature and use o_GameManager.level.update or do something else
paused = false;

with(o_MusicManager) {
	stopMusic(true);
	stopTempSong();
	playNewSong(music_pizzatime);
}

instance_destroy(o_Le_RedGuy);