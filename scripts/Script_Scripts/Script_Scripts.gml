function PlaySound(snd, override = false, loop = false, canRepeat = false) {
	if(audio_is_playing(snd) && !override && !canRepeat || global.settings.audioSettings.muteAll) {
		return -1;
	}
	if(override) audio_stop_sound(snd);
	var aud = audio_play_sound(snd, 999, loop);
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
function GetAllInput(reqKey, inputType = 0) {
	for(var i = 1; i <= o_MultiplayerSystem.totalPlayers;i++) {
		var s = variable_struct_get(global.settings.keyBinds, "p" + string(i));
		var c = undefined;
			switch(inputType) {
				case 0:
					c = keyboard_check(variable_struct_get(s, reqKey));
				break;
		
				case 1:
					c = keyboard_check_pressed(variable_struct_get(s, reqKey));
				break;
		
				case 2:
					c = keyboard_check_released(variable_struct_get(s, reqKey));
				break;
			}
		if(c) return [c, i];
	}
	return [false, -1];
}
function CollideAndMove(mass, maxYVelocity = 20) {
	if(!PLAYER_GROUNDED) velocity[1] += mass;
	velocity[1] = clamp(velocity[1], -maxYVelocity, maxYVelocity);
repeat(abs(velocity[1])) {
    if !place_meeting(x, y + sign(velocity[1]), o_C_Parent)
        y += sign(velocity[1]); 
    else {
        velocity[1] = 0;
        break;
    }
}

// Horizontal
repeat(abs(velocity[0])) {
    // Move up slope
    if place_meeting(x + sign(velocity[0]), y, o_C_Parent) && !place_meeting(x + sign(velocity[0]), y - 1, o_C_Parent)
        y--
    
    // Move down slope
    if !place_meeting(x + sign(velocity[0]), y, o_C_Parent) && !place_meeting(x + sign(velocity[0]), y + 1, o_C_Parent) && place_meeting(x + sign(velocity[0]), y + 2, o_C_Parent)
        y++;

    if !place_meeting(x + sign(velocity[0]), y, o_C_Parent)
        x += sign(velocity[0]); 
    else {
        velocity[0] = 0;
        break;
    }
}
	/*
	if(place_meeting(x + velocity[0], y, o_C_Parent)) {
		// Alternative: if(!place_meeting(x + velocity[0], y - (abs(velocity[0]) + 1), o_C_Parent ) ) while(place_meeting(x + velocity[0], y, o_C_Parent)) y--;
		for(var i = 0 ; i <= abs(velocity[0] * 16);i++) {
			if(!place_meeting(x+velocity[0], y - i, o_C_Parent)) {
				y -= i;
				break;
			}
		}
		if(place_meeting(x+velocity[0],y,o_C_Parent)) {
			while(!place_meeting(x+sign(velocity[0]), y, o_C_Parent)) x += sign(velocity[0]);
			velocity[0] = 0;
		}
	}
	if(place_meeting(x + velocity[0], y + velocity[1], o_C_Parent)) {
		while(!place_meeting(x + velocity[0], y + sign(velocity[1]), o_C_Parent)) {
			y += sign(velocity[1]);
		}
		velocity[1] = 0;
	}
	x += velocity[0];
	y += velocity[1];
	*/
}
function ApplySettings() {
	if(global.settings.gameplaySettings.multiplayer) {
		if(!instance_exists(o_MultiplayerSystem)) instance_create_depth(0,0,0,o_MultiplayerSystem)
		if(instance_exists(o_PlayerParent)) CreatePlayer(o_PlayerParent.x,o_PlayerParent.y);
	}
	var type = [[480, 270], [960, 540], [1920, 1080]];
	window_set_size(type[global.settings.videoSettings.resolutionOpt][0], type[global.settings.videoSettings.resolutionOpt][1]);
	window_set_fullscreen(global.settings.videoSettings.fullscreen);
	display_reset(0, global.settings.videoSettings.vSync);
	if(global.settings.gameplaySettings.debugEnabled && !instance_exists(o_DEBUG_Console)) instance_create_depth(0,0,0, o_DEBUG_Console);
	if(global.settings.audioSettings.muteAll && instance_exists(o_MusicManager)) instance_destroy(o_MusicManager);
	else instance_destroy(o_DEBUG_Console);
	
	
	Log("Applied Settings!");
}
function SaveSettings() {
	if(global.settings.saveFileIndex == -1) return;
	directory_create("MaximizedGM2");
	var toString = json_stringify(global.settings);
	var buf = buffer_create(string_length(toString), buffer_grow, 1); //Make it like this for buffer_load to be happy!
	buffer_write(buf, buffer_string, toString);
	//buffer_compress(buf, 0, buffer_tell(buf));
	buffer_save(buffer_compress(buf, 0, buffer_tell(buf)), "MaximizedGM2/file" + string(global.settings.saveFileIndex) + ".txt");
	buffer_delete(buf);
	Log("Saved Settings!");
}
function LoadSettings() {
	var INVALID = false;
	if(global.settings.saveFileIndex == -1) return INVALID;
	var file = buffer_load("MaximizedGM2/file" + string(global.settings.saveFileIndex) + ".txt");
	if(file == -1) {
		Log("Cannot load settings! (File doesn't exist, or something else.)");
		return INVALID;
	}
	var parsed = json_parse(buffer_read(buffer_decompress(file), buffer_string));
	if(parsed == -1) {
		LogError("This is fatal. We cannot read the save file.");
		return INVALID;
	}
	var names = variable_struct_get_names(global.settings);
	for(var i = 0 ; i < array_length(names);i++) variable_struct_set(global.settings, names[i], variable_struct_get(parsed, names[i])); //This will let the future settings still exist, while updating the previous version.
	buffer_delete(file);
	Log("Loaded Settings!");
}
function GetPlayer() {
	return instance_nearest(x,y,o_PlayerParent);
}
function CreateParticle(x,y, ob) {
	var o = instance_create_depth(x,y, 10, ob);
	o.parent = object_index;
}
function GetParticle(reqOb) {
	var inst = noone;
	for(var i = 0 ; i < instance_number(o_P_Parent);i++) {
		inst = instance_find(o_P_Breakable, i);
		if(reqOb == inst.object_index && inst.parent == object_index) return instance_find(o_P_Breakable, i).object_index;
	}
	return noone;
}
function CreateEffect(information) {
	if(!is_struct(information)) LogError("Invalid Effect!", true);
	if(information.sprite_index == sprite_effect_bang) PlaySound(choose(sfx_punch1, sfx_punch2, sfx_punch3, sfx_punch4, sfx_punch5))
	
	for(var i = 0 ; i < instance_number(o_P_Effect);i++) {
		if(instance_find(o_P_Effect, i).sprite_index == information.sprite_index) return;
	}
	instance_create_depth(x,y,0,o_P_Effect, information);
}
function LogError(_message, crash = false) {
	//if(!global.settings.gameplaySettings.debugEnabled) return;
	Log("LogError Message: " + _message);
	if(!instance_exists(o_GUI)) instance_create_depth(0,0,0,o_GUI);
	o_GUI.alert("From object id " + string(id) + " (" + object_get_name(object_index) + ") :\n" + _message);
	//show_message("From object id " + string(id) + " (" + object_get_name(object_index) + ")\n" + _message);
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
	var LOG_EXTRA = false;
	var log = "(" + string(get_timer() / 1_000_000) ;
	if(LOG_EXTRA) log += ", " + StrCat(room, _GMFILE_, _GMFUNCTION_, _GMLINE_ );
	log += ") : " + _message;
	show_debug_message(log);
	with(o_DEBUG_Console) {
		array_resize(logs, array_length(logs) + 1);
		logs[array_length(logs) - 1] = log;
	}
}
function CreatePlayer(targX,targY) {
	if(instance_number(o_PlayerParent) > 1 && !global.settings.gameplaySettings.multiplayer) {
		Log("Attemped to create an extra player whilist not in multiplayer, cancelling...");
		return;
	}
	var inst = o_PlayerParent;
    switch(global.settings.playerSettings.moveSet) {
	    case Moveset.PreETB:
	        inst = o_Player_PreETB;
	    break;
		
		case Moveset.TheNoise:
			inst = o_Player_Noise;
		break;
        		
	    case Moveset.ETB:
        	inst = o_Player_ETB;
        break;
		
		default:
			LogError("Failed to find the correct player! Defaulting to ETB...");
			inst = o_Player_ETB;
		break;
    }
	Log("Creating Player (" + object_get_name(inst) + ")");
    instance_create_depth(targX,targY, -6, inst);
}
function ForEachPlayer(func) {
	var amt = instance_exists(o_MultiplayerSystem) ? o_MultiplayerSystem.totalPlayers : instance_number(o_PlayerParent);
	for(var i = 0 ; i < amt;i++) {
		func(instance_find(o_PlayerParent, i), i);
	}
}