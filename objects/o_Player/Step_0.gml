//if(global.settings.multiplayerSettings.enabled && playerID == -1) throw("I have ID -1!");
if(global.settings.gameplaySettings.fpsSave != FPSSaveMode.UselessRemover) {
	var len = array_length(sounds);
	for(var i = 0 ; i < len;i++) {
		if(!audio_is_playing(sounds[i])) {
			audio_stop_sound(sounds[i]);
			len--;
			for(var j = i; j < len;j++) {
				sounds[j] = sounds[j + 1];
			}
		}
	}
}
if(velocity.x != 0 || velocity.y != 0) {
	audio_listener_position(room_width - x, y, depth);
	audio_listener_velocity(velocity.x, velocity.y, 0);
	//audio_listener_orientation(x, y, 0, 0, 0, 0);
}

HandlePlayer(global.settings.playerSettings.moveSet);