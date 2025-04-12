songID = -1;
playNewMusic = function(song) {
	if(song == -1) return;
	if(songID != -1) audio_sound_gain(songID, 0, 1000);
	var aud = PlaySound(music_pizza, false, true);
	if(aud == -1) return;
	audio_sound_gain(aud, 0,0);
	audio_sound_gain(aud, 1, 1000);
	songID = aud;
}
setMusicPlaying = function(value) {
	if(value) audio_pause_sound(songID);
	else audio_resume_sound(songID);
}
playNewMusic(music_pizza);