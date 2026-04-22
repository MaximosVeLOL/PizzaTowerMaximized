function Vector(_x = 0, _y = 0) constructor {
	x = _x;
	y = _y;
}

//#macro BASE_DIRECTORY "%localappdata%/Pizza_Tower/MaximizedGM2"
#macro BASE_DIRECTORY working_directory + "MaximizedGM2"
function instance_create(x, y, object, var_struct = {}) {
	return instance_create_layer(x, y, (layer == -1 ? layer_get_id("Instances") : layer), object, var_struct);
}

function GetAsTime(val) {
	var text = "";
	var minutes = floor(val / 60);
	var seconds = round(val % 60);
	//Avoid doing calculations again? I don't know if thats how computers work.
	if(seconds == 60) seconds = 0;
	text += minutes < 1 ? "0" : string(minutes);
	text += seconds < 10 ? ":0" + string(seconds) : ":" + string(seconds);
	return text;
}

function PlaySound(snd, override = false, loop = false, canRepeat = false) {
	var aud = -1;
	try {
		if(audio_is_playing(snd) && !override && !canRepeat || global.settings.audio.muteAll) {
			return -1;
		}
		if(override) audio_stop_sound(snd);
		
		aud = global.settings.audio.surroundSound ? audio_play_sound_at(snd, x, y, 0, 100, 300, 0, loop, 999) : audio_play_sound(snd, 999, loop);
		if(aud != -1 && !loop) audio_sound_gain(aud, global.settings.audio.sfxVolume / 100, 0);
	}
	return aud;
}
function PlaySoundSpacial(snd, override = false, loop = false, canRepeat = false) {
	if(audio_is_playing(snd) && !override && !canRepeat || global.settings.audio.muteAll) {
		return -1;
	}
	if(override) audio_stop_sound(snd);
	var aud = audio_play_sound_at(snd, x, y, depth, 100, 300, 0, loop, 999);
	if(!loop) audio_sound_gain(aud, global.settings.audio.sfxVolume / 100, 0);
	return aud;
}
function GetInput(reqKey, inputType = 0, reqPlayer = 0) {
	var s = variable_struct_get(global.settings.keyBinds, "p" + string(reqPlayer));
	//show_message(s);
	//Log(string(s));
	//Log(string(reqPlayer));
	switch(inputType) {
		case 0:
			return keyboard_check(variable_struct_get(s, reqKey)) || gamepad_button_check(reqPlayer, variable_struct_get(variable_struct_get(s, "gamepad"), reqKey));
		break;
		
		case 1:
			return keyboard_check_pressed(variable_struct_get(s, reqKey)) || gamepad_button_check_pressed(reqPlayer, variable_struct_get(variable_struct_get(s, "gamepad"), reqKey));
		break;
		
		case 2:
			return keyboard_check_released(variable_struct_get(s, reqKey)) || gamepad_button_check_released(reqPlayer, variable_struct_get(variable_struct_get(s, "gamepad"), reqKey));
		break;
	}
	throw("Que?"); //We will never get to this point, unless the input type isn't set correctly
}
function LogError(_message, crash = false) {
	//if(!global.settings.gameplay.debugEnabled) return;
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

//https://gmlscripts.com/script/draw_sprite_tiled_area
function draw_sprite_tiled_area(sprite, subimg, x, y, x1, y1, x2, y2)
{
    var sw = sprite_get_width(sprite);
    var sh = sprite_get_height(sprite);
 
    var i = x1 - ((x1 mod sw) - (x mod sw)) - sw * ((x1 mod sw) < (x mod sw));
    var j = y1 - ((y1 mod sh) - (y mod sh)) - sh * ((y1 mod sh) < (y mod sh));
    var jj = j;
 
    var left,top,width,height,px,py;
    for (i=i; i<=x2; i+=sw) {
        for (j=j; j<=y2; j+=sh) {
 
            left = (i <= x1) ? x1 - i : 0;
            px = i + left;
 
            top = (j <= y1) ? y1 - j : 0;
            py = j + top;
 
            width = (x2 <= i + sw) ? (sw - (i + sw - x2) + 1) - left : sw - left;
            height = (y2 <= j + sh) ? (sh - (j + sh - y2) + 1) - top : sh - top;
 
            draw_sprite_part(sprite, subimg, left, top, width, height, px, py);
        }
        j = jj;
    }
    return 0;
}
function BetterLerp(a, b, c) {
	var LERP_RANGE = 0.2;
	var ret = lerp(a, b, c);
	if(ret <= b - LERP_RANGE && ret >= b + LERP_RANGE)
		return b;
	return ret;
}