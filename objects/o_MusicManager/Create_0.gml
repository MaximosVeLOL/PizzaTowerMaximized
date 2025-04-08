songID = -1;
nextSong = -1;
loopPoint = 0;
playNewMusic = function(song, _loopPoint = 0) {
	audio_sound_gain(songID, 0, 1);
	var aud = PlaySound(song);
	audio_sound_gain(aud, 0,0);
	audio_sound_gain(aud, 1, 1);
	loopPoint = _loopPoint;
	alarm[0] = audio_sound_length(song) * game_get_speed(gamespeed_fps);
}