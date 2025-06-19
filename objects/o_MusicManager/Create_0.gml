currentSong = -1;
lastSong = -1;
loopPointStart = -1;
loopPointEnd = -1;
tempSong = -1;
playNewSong = function(newSong, loopData = [-1,-1]) {
	Log("Playing New Song!\nInformation: [name: " + string(newSong) + "]");
	if(newSong == -1 || global.settings.audioSettings.musicVolume == 0 || (instance_exists(o_PizzaTimeManager) && newSong != music_pizzatime) || newSong == asset_get_index(audio_get_name(currentSong))|| tempSong != -1) return;
	if(currentSong != -1) { //If we are already playing music, we stop it
		audio_sound_gain(currentSong, 0, 1000); //1000 ms = 1 second
		lastSong = currentSong;
		alarm[0] = 60; // 60 = 1 second
		currentSong = PlaySound(newSong, true, true);
		audio_sound_gain(currentSong, 0, 0);
		audio_sound_gain(currentSong, (global.settings.audioSettings.musicVolume / 100), 1000);
	}
	else {
		currentSong = PlaySound(newSong, true, true); //Play song at max volume
		audio_sound_gain(currentSong, (global.settings.audioSettings.musicVolume / 100), 0);
	}
	if(loopData[0] == -1 || loopData[1] == -1) {
		Log("Invalid Loop Data Length! (-1, -1)");
		loopData[0] = 0;
		loopData[1] = audio_sound_length(currentSong);
	}
	audio_sound_loop_start(currentSong, loopData[0]);
	audio_sound_loop_end(currentSong, loopData[1]);
	
}
tempPlaySong = function(newSong) {
	if(newSong == -1 || global.settings.audioSettings.musicVolume == 0 || instance_exists(o_PizzaTimeManager) || newSong == asset_get_index(audio_get_name(currentSong)) ) return;
	Log("New temporary song!");
	audio_pause_sound(currentSong);
	tempSong = PlaySound(newSong, true, true);
}
stopTempSong = function() {
	if(global.settings.audioSettings.musicVolume == 0 || tempSong == -1) return;
	Log("Stopping temporary song!");
	audio_stop_sound(tempSong);
	audio_resume_sound(currentSong);
}
stopMusic = function(instantly = true) {
	lastSong = currentSong;
	if(instantly) {
		audio_sound_gain(lastSong, 0, 1000);
		alarm[0] = 60;
	}
	else audio_stop_sound(lastSong);
	
	currentSong = -1;
}