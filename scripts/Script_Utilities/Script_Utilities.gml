function Vector(_x = 0, _y = 0) constructor {
	x = _x;
	y = _y;
}


function PlaySound(snd, override = false, loop = false, canRepeat = false) {
	var aud = -1;
	try {
		if(audio_is_playing(snd) && !override && !canRepeat || global.settings.audioSettings.muteAll) {
			return -1;
		}
		if(override) audio_stop_sound(snd);
		
		aud = global.settings.audioSettings.surroundSound ? audio_play_sound_at(snd, x, y, 0, 100, 300, 0, loop, 999) : audio_play_sound(snd, 999, loop);
		if(!loop) audio_sound_gain(aud, global.settings.audioSettings.sfxVolume / 100, 0);
	}
	return aud;
}
function PlaySoundSpacial(snd, override = false, loop = false, canRepeat = false) {
	if(audio_is_playing(snd) && !override && !canRepeat || global.settings.audioSettings.muteAll) {
		return -1;
	}
	if(override) audio_stop_sound(snd);
	var aud = audio_play_sound_at(snd, x, y, depth, 100, 300, 0, loop, 999);
	if(!loop) audio_sound_gain(aud, global.settings.audioSettings.sfxVolume / 100, 0);
	return aud;
}
function GetInput(reqKey, inputType = 0, reqPlayer = 1) {
	var s = variable_struct_get(global.settings.keyBinds, "p" + string(reqPlayer));
	//show_message(s);
	switch(inputType) {
		case 0:
			return keyboard_check(variable_struct_get(s, reqKey)) || gamepad_button_check(reqPlayer - 1, variable_struct_get(variable_struct_get(s, "gamepad"), reqKey));
		break;
		
		case 1:
			return keyboard_check_pressed(variable_struct_get(s, reqKey)) || gamepad_button_check_pressed(reqPlayer - 1, variable_struct_get(variable_struct_get(s, "gamepad"), reqKey));
		break;
		
		case 2:
			return keyboard_check_released(variable_struct_get(s, reqKey)) || gamepad_button_check_released(reqPlayer - 1, variable_struct_get(variable_struct_get(s, "gamepad"), reqKey));
		break;
	}
	throw("Que?"); //We will never get to this point, unless the input type isn't set correctly
}
function LogError(_message, crash = false) {
	//if(!global.settings.gameplaySettings.debugEnabled) return;
	Log("LogError Message: " + _message);
	show_message("From object id " + string(id) + " (" + object_get_name(object_index) + ")\n" + _message);
	if(crash) throw("LogError Automatic Crash!");
}
function StrCat() {
	var s = "";
	for(var i = 0 ; i < argument_count;i++) {
		s += string(argument[i]) + ", ";
	}
	return s;
}
function Log(_message) { // 0 1 2 3 (size = 4)
	if(!instance_exists(o_DEBUG_Console)) return;
	
	
	
	var log = "(" + string(get_timer() / 1_000_000) ;
	if(false) log += ", " + StrCat(room, _GMFILE_, _GMFUNCTION_, _GMLINE_ );
	log += ") : " + _message;
		if(array_length(o_DEBUG_Console.logs) > 1 && log == o_DEBUG_Console.logs[array_length(o_DEBUG_Console.logs) - 1]) return; //This would always fail, because we add extra information to it.

	show_debug_message(log);
	with(o_DEBUG_Console) {
		array_resize(logs, array_length(logs) + 1);
		logs[array_length(logs) - 1] = log;
	}
}

function ResetAllRooms(startingRoom = room_first, endingRoom = room_last) {

}