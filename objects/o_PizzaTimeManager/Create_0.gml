paused = false;
if(global.settings.gameplaySettings.fpsSave == FPSSaveMode.OnlyTheNeccessary) {
	instance_destroy(); //Bye bye...
}
if(instance_exists(o_MusicManager)) o_MusicManager.playNewSong(music_pizzatime);