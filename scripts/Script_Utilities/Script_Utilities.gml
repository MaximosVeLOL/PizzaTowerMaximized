function Vector(_x = 0, _y = 0) constructor {
	x = _x;
	y = _y;
}




//#macro BASE_DIRECTORY "%localappdata%/Pizza_Tower/MaximizedGM2"
#macro BASE_DIRECTORY working_directory + "MaximizedGM2"
function instance_create(x, y, object, var_struct = {}) {
	return instance_create_layer(x, y, (layer == -1 ? layer_get_id("Instances") : layer), object, var_struct);
}

function GetAsTime(val, showMili = false) {
	var text = "";
	var minutes = floor(val / 60);
	var seconds = round(val % 60);
	//Avoid doing calculations again? I don't know if thats how computers work.
	if(seconds == 60)
        seconds = 0;
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
#macro I_WENTDOWN 1
#macro I_DOWN 0
#macro I_WENTUP 2

//Web builds have no good features
#macro IS_WEB_BUILD (os_type == os_operagx || os_browser != browser_not_a_browser)
//GML natively supports windows, so we have to do this in order to maintain compatability between others
#macro IS_WINDOWS (os_type == os_windows)

function GetInput(pInputCode, pInputState = I_DOWN, pProfileIndex = 0) {
	//The name of the key
	//Woah
	return [keyboard_check, keyboard_check_pressed, keyboard_check_released][pInputState](variable_struct_get(variable_struct_get(global.settings.keyBinds, "p" + string(pProfileIndex)), pInputCode));
}



/*function GetInput(reqKey, inputType = 0, reqPlayer = 0) {
	var s = variable_struct_get(global.settings.keyBinds, "p" + string(reqPlayer));
	//show_message(s);
	//Log(string(s));
	//Log(string(reqPlayer));
	
	var ret = false;
	
	switch(inputType) {
		case 0:
			ret = keyboard_check(variable_struct_get(s, reqKey)) || 
				gamepad_button_check(reqPlayer, variable_struct_get(variable_struct_get(s, "gamepad"), reqKey));
		break;
		
		case 1:
			ret = keyboard_check_pressed(variable_struct_get(s, reqKey)) || gamepad_button_check_pressed(reqPlayer, variable_struct_get(variable_struct_get(s, "gamepad"), reqKey));
		break;
		
		case 2:
			ret = keyboard_check_released(variable_struct_get(s, reqKey)) || gamepad_button_check_released(reqPlayer, variable_struct_get(variable_struct_get(s, "gamepad"), reqKey));
		break;
	}
	return
	throw("Que?"); //We will never get to this point, unless the input type isn't set correctly
}*/
function StrCat() {
	var s = "";
	for(var i = 0 ; i < argument_count;i++) {
		s += string(argument[i]) + ", ";
	}
	return s;
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

function Grid(value, pMethod = 0, grid = 32) {
	//return round(value / gridSize) * gridSize;
	return [round, floor, ceil][pMethod](value / grid) * grid;
}

function TextureGroupEnsureLoaded(pName) {
    if(texturegroup_get_status(pName) < texturegroup_status_loaded) {
        throw("(TextureGroupEnsureLoaded) Not loaded! (" + pName + ")");
    }
}

function GamepadDetectAny(pPadIndex = 0) {
	
	
	return gamepad_is_connected(pPadIndex) && (gamepad_button_check(pPad, gp_face1) || gamepad_button_check(pPad, gp_face2) || gamepad_button_check(pPad, gp_face3) || gamepad_button_check(pPad, gp_face4) 
		|| gamepad_button_check(pPad, gp_shoulderl) || gamepad_button_check(pPad, gp_shoulderlb) || gamepad_button_check(pPad, gp_shoulderr) || gamepad_button_check(pPad, gp_shoulderrb)
		|| gamepad_button_check(pPad, gp_padu) || gamepad_button_check(pPad, gp_padd) || gamepad_button_check(pPad, gp_padl) || gamepad_button_check(pPad, gp_padr)
	);
}