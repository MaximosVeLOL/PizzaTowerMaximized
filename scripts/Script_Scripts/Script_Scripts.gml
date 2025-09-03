function ShakeCamera(mag, acc) {
	o_Camera.shake.mag = mag;
	o_Camera.shake.acc = acc;
	ShakeEnemies();
}
function ShakeEnemies() {
	with(o_Le_En_Parent) {
		if(point_in_rectangle(x,y,camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]), camera_get_view_x(view_camera[0]) + 960, camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + 540 )) {
			velocity = [0, -7];
		}
	}
}

function CollideAndMove(mass, maxYVelocity = 20, useSlopes = true) {
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
	if(useSlopes) {
	    // Move up slope
	    if place_meeting(x + sign(velocity[0]), y, o_C_Parent) && !place_meeting(x + sign(velocity[0]), y - 1, o_C_Parent)
	        y--
    

	    // Move down slope
	    if !place_meeting(x + sign(velocity[0]), y, o_C_Parent) && !place_meeting(x + sign(velocity[0]), y + 1, o_C_Parent) && place_meeting(x + sign(velocity[0]), y + 2, o_C_Parent)
	        y++;
	}

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
	Log("Going to apply settings...")
	if(os_browser != browser_not_a_browser) return;
	
	if(global.settings.audioSettings.muteAll) {
		audio_stop_all();
	}
	else {
		if(!instance_exists(o_MusicManager)) instance_create_depth(0,0,0,o_MusicManager);
	}
	
	if(global.settings.gameplaySettings.debugEnabled) {
		if(!instance_exists(o_DEBUG_Console)) instance_create_depth(0,0,0,o_DEBUG_Console);
	}
	else instance_destroy(o_DEBUG_Console);
	show_message(PlayerObjectToMovesetEnum(o_PlayerParent));
	if(global.settings.playerSettings.moveSet != PlayerObjectToMovesetEnum(o_PlayerParent)) {
		if(room != Room_DemoRoom && room != Room_MainMenu) {
			show_message("You can only change movesets when you are not in a level!");
		}
		else { //You still want to apply the other settings, so using return isn't an option
			var PlayerPos = [o_PlayerParent.x, o_PlayerParent.y];
			instance_destroy(o_PlayerParent);
			CreatePlayer(PlayerPos[0], PlayerPos[1]);
		}
	}
	window_set_fullscreen(global.settings.videoSettings.fullscreen);
	display_reset(display_aa, global.settings.videoSettings.vSync);
	
	Log("Successfully applied settings!"); //So many repeating letters
}
function SaveSettings() {
	Log("Going to save settings...");
	if(global.settings.saveFileIndex == -1 || os_browser != browser_not_a_browser) return;
	//if(!directory_exists("MaximizedGM2")) directory_create("MaximizedGM2");
	//if(!directory_exists("MaximizedGM2/Save" + string(global.settings.saveFileIndex))) directory_create("MaximizedGM2/Save");
	
	//There are faster ways to do this, but this is the most efficient way to do it.
	var toString = json_stringify(global.settings);
	var buf = buffer_create(string_length(toString), buffer_grow, 1); //Make it like this for buffer_load to be happy!
	buffer_write(buf, buffer_string, toString);
	//buffer_compress(buf, 0, buffer_tell(buf));
	buffer_save(buffer_compress(buf, 0, buffer_tell(buf)), "MaximizedGM2/Save" + string(global.settings.saveFileIndex) + "/settings.PTM");
	buffer_delete(buf);
	Log("Saved Settings!");
}
function LoadSettings() {
	Log("Going to load settings...");
	if(global.settings.saveFileIndex == -1 || os_browser != browser_not_a_browser) return false;
	var file = buffer_load("MaximizedGM2/Save" + string(global.settings.saveFileIndex) + "/settings.PTM");
	if(file == -1) {
		Log("Cannot load settings! (File doesn't exist, or something else.)");
		return false;
	}
	var parsed = buffer_read(buffer_decompress(file), buffer_string)
	if(parsed == -1) {
		LogError("This is fatal. We cannot read the save file.");
		return false;
	}
	parsed = json_parse(parsed);
	var names = variable_struct_get_names(global.settings);
	for(var i = 0 ; i < array_length(names);i++) variable_struct_set(global.settings, names[i], variable_struct_get(parsed, names[i])); //This will let the future settings still exist, while updating the previous version.
	buffer_delete(file);
	gc_collect();
	Log("Successfully loaded settings!");
	return true;
}
function CreateEffect(information) {
	//if(!is_struct(information)) LogError("Invalid Effect!", true);
	if(information.sprite_index == sprite_effect_bang) PlaySound(choose(sfx_punch1, sfx_punch2, sfx_punch3, sfx_punch4, sfx_punch5))
	
	for(var i = 0 ; i < instance_number(o_P_Effect);i++) {
		//M_OPTI - Find a better way to check for same effects
		if(instance_find(o_P_Effect, i).sprite_index == information.sprite_index) return;
	}
	instance_create_depth(x,y,-100,o_P_Effect, information);
}
function CreatePlayer(targX,targY) {
	var movesets = [o_Player_PreETB, o_Player_ETB];
	var inst = movesets[global.settings.playerSettings.moveSet]; //Big brain
	//M_OPTI - Do we really need inst?
	Log("Creating Player (" + object_get_name(inst) + ")");
	return instance_create_depth(targX,targY, -6, inst);
	/*
	with() {
		PD = instance_exists(o_MultiplayerSystem) ? o_MultiplayerSystem.registerPlayer() : 1;
	}*/

}
function PlayerObjectToMovesetEnum(inObject) {
	var movesets = [Moveset.PreETB, Moveset.ETB];
	var objects = [o_Player_PreETB, o_Player_ETB];
	for(var i = 0 ; i < array_length(objects);i++) {
		if(inObject == objects[i] ) return movesets[i];
	}
}