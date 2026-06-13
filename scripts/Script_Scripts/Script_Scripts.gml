function ShakeCamera(mag, acc) {
	if(IS_DEBUGGING && !instance_exists(o_Camera)) return;
	o_Camera.shake.mag = mag;
	o_Camera.shake.acc = acc;
	with(o_Le_En_Parent) {
		if(object_index != o_Le_En_Cheeseslime && point_in_rectangle(x,y,camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]), camera_get_view_x(view_camera[0]) + 960, camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + 540 )) {
			velocity.x = 0;
			velocity.y = -7;
			setState(EnemyState.Hit);
			sprite_index = sprite.hit;
			tempVar[0] = 200;
		}
	}
}

function CollideAndMove(mass, maxYVelocity = 20, interactWithWater = false, useSlopes = true) {
	if(!PLAYER_GROUNDED) velocity.y += (place_meeting(x, y, o_Le_Water) && interactWithWater && global.settings.player.waterInteraction ? (global.settings.player.moveSet == Moveset.ETB ? (velocity.y >= 0 ? mass/1.25 : mass*1.25) : mass / 1.5) : mass);
	
	repeat(abs(velocity.y)) {
	    if !place_meeting(x, y + sign(velocity.y), o_C_Parent)
	        y += sign(velocity.y); 
	    else {
	        velocity.y = 0;
	        break;
	    }
	}

	// Horizontal
	repeat(abs(velocity.x)) {

		if(useSlopes) {
		    // Move up slope
		    if place_meeting(x + sign(velocity.x), y, o_C_Parent) && !place_meeting(x + sign(velocity.x), y - 1, o_C_Parent)
		        y--
    

		    // Move down slope
		    if !place_meeting(x + sign(velocity.x), y, o_C_Parent) && !place_meeting(x + sign(velocity.x), y + 1, o_C_Parent) && place_meeting(x + sign(velocity.x), y + 2, o_C_Parent)
		        y++;
		}

	    if !place_meeting(x + sign(velocity.x), y, o_C_Parent)
	        x += sign(velocity.x); 
	    else {
	        velocity.x = 0;
	        break;
	    }
	}
	/*
	if(place_meeting(x + velocity.x, y, o_C_Parent)) {
		// Alternative: if(!place_meeting(x + velocity.x, y - (abs(velocity.x) + 1), o_C_Parent ) ) while(place_meeting(x + velocity.x, y, o_C_Parent)) y--;
		for(var i = 0 ; i <= abs(velocity.x * 16);i++) {
			if(!place_meeting(x+velocity.x, y - i, o_C_Parent)) {
				y -= i;
				break;
			}
		}
		if(place_meeting(x+velocity.x,y,o_C_Parent)) {
			while(!place_meeting(x+sign(velocity.x), y, o_C_Parent)) x += sign(velocity.x);
			velocity.x = 0;
		}
	}
	if(place_meeting(x + velocity.x, y + velocity.y, o_C_Parent)) {
		while(!place_meeting(x + velocity.x, y + sign(velocity.y), o_C_Parent)) {
			y += sign(velocity.y);
		}
		velocity.y = 0;
	}
	x += velocity.x;
	y += velocity.y;
	*/
}
#macro SETTINGS_VERSION 0x01
/* Versions:
 * 0 - JSON version (very bulky and unsafe for future builds,
 * As values can be removed and then makes everything worse)
 * 1 - Custom version (small file size with better optimizations.
 * Instead of using JSON stringify, we can only export the values,
 * Which saves alot of space. And plus, the JSONs were never readable.
*/
function ApplySettings() {
	Log("Going to apply .settings..")
	if(os_browser != browser_not_a_browser) return;
	if(global.settings.audio.muteAll) {
		audio_stop_all();
		if(instance_exists(o_MusicManager))
			instance_destroy(o_MusicManager);
	}
	else {
		if(!instance_exists(o_MusicManager))
			instance_create_depth(0,0,0,o_MusicManager);
	}
	if(global.settings.multiplayer.enabled) {
		if(!instance_exists(o_MultiplayerHandler)) {
			instance_create_depth(0, 0, 0, o_MultiplayerHandler);
		}
		else {
			for(var i = 0 ; i < instance_number(o_Player);i++) {
				o_MultiplayerHandler.DefinePlayer(instance_find(o_Player, i), i);
			}
		}
		//If the camera type changed, which doesn't matter when not changed.
		if(instance_exists(o_Camera)) o_Camera.setupRoom();
		//for (var i = 0 ; i < instance_number(o_Player);i++)
		//	o_MultiplayerHandler.DefinePlayer(instance_find(o_Player, i), i);
	}
	else if(instance_exists(o_MultiplayerHandler))
		instance_destroy(o_MultiplayerHandler);
	if(global.settings.gameplay.debugEnabled) {
		if(!instance_exists(o_DEBUG_Console)) instance_create_depth(0,0,0,o_DEBUG_Console);
	}
	else instance_destroy(o_DEBUG_Console);
	//show_message(PlayerObjectToMovesetEnum(o_Player));
	//var m = PlayerObjectToMovesetEnum(o_Player);
	/*
	if(global.settings.player.moveSet != m && m != Moveset.Invalid) {
		if(room != Room_DemoRoom && room != Room_MainMenu) {
			show_message("You can only change movesets when you are not in a level!");
		}
		else { //You still want to apply the other settings, so using return isn't an option.
			var PlayerPos = [o_Player.x, o_Player.y];
			instance_destroy(o_Player);
			CreatePlayer(PlayerPos[0], PlayerPos[1]);
		}
	}
	The way movesets are handled now destroy this.settings..
	
	*/
	window_set_fullscreen(global.settings.video.fullscreen);
	display_reset(display_aa, global.settings.video.vSync);
	
	Log("Successfully applied settings!"); //So many repeating letters
}
function SaveSettings() {
	Log("Going to save ...");
	if(global.settings.saveFileIndex == -1 || os_browser != browser_not_a_browser) return;
	//if(!directory_exists("MaximizedGM2")) directory_create("MaximizedGM2");
	//if(!directory_exists("MaximizedGM2/Save" + string(global.settings.saveFileIndex))) directory_create("MaximizedGM2/Save");
	
	//There are faster ways to do this, but this is the most efficient way to do it.
	var buf = buffer_create(0, buffer_grow, 1);
	if(buf == -1) {
		Log("Failed to create the settings buffer!");
		return;
	}
	if(SETTINGS_VERSION == 0x00) {
		var toString = json_stringify(global.settings);
		//buf = buffer_create(string_length(toString), buffer_grow, 1); //Make it like this for buffer_load to be happy!
		buffer_write(buf, buffer_string, toString);
	}
	else {
		//All settings are stored as structs
		//Struct values are what is stored
		//Every value in a struct should be 1 byte
		//The only values that shouldn't are the keyBinds struct.
		//So we either need to store them seperately or make them special.
		//I'm going to make them special.

		//The version of the settings file
		//0 - JSON Version
		//1 - Custom struct version
		buffer_write(buf, buffer_u8, SETTINGS_VERSION);
		//var settingNames = struct_get_names(global.settings);
		//Override the order so gamemaker doesn't make this confusing
		var settingNames = [
			//Struct of binding structs
			//"keyBinds",
			//The rest are fine
			"audio",
			"video",
			"gameplay",
			"player",
			"multiplayer"
		];
		//Override cuz I don't know how to remove gamepad name because of Gamemaker nonsense
		var valueNames = [
			"up",
			"down",
			"left",
			"right",
			"jump",
			"dash",
			"shoot",
		];
		var settings = undefined;
		var values = undefined;
		
		//Keybinds are very special, so we seperate them from the others
		
		//512 keys exist for keyboard, so ushort.
		//Gamepad buttons take up a ushort, so ushort.
		var keyType = buffer_u16;
		
		//All binding structs have the same values, so we don't need to do this in the loop
		//valueNames = variable_struct_get_names(variable_struct_get(global.settings.keyBinds, "p0"));
		//Log("Writing keyBinds");
		for(var i = 0 ; i < 4;i++) {
			//Get current binding struct
			values = variable_struct_get(global.settings.keyBinds, "p" + string(i));
			//Log(string(values));
			for(var j = 0 ; j < array_length(valueNames);j++) {
				//Log("Applying key (" + valueNames[j] + ") for keyboard");
				
				//Write keys
				buffer_write(buf, keyType, variable_struct_get(values, valueNames[j]));
			}
			//Write gamepad bindings
			values = variable_struct_get(values, "gamepad");
			for(var j = 0 ; j < array_length(valueNames);j++) {
				//Log("Applying key (" + valueNames[j] + ") for gamepad");
				//Write keys
				buffer_write(buf, keyType, variable_struct_get(values, valueNames[j]));
			}
		}
		
		for(var i = 0 ; i < array_length(settingNames);i++) {
			settings = variable_struct_get(global.settings, settingNames[i]);
			valueNames = variable_struct_get_names(settings);
			//Log("Going to write section (" + settingNames[i] + ")");
			for(var j = 0 ; j < array_length(valueNames);j++) {
				//Log("Writing option (" + valueNames[j] + ")");
				buffer_write(buf, buffer_u8, variable_struct_get(settings, valueNames[j]));
			}
		}
		//buffer_compress(buf, 0, buffer_tell(buf));
	}
	//We still compressed because of wasted values for the keyboard and ect (uncompressed: 130, compressed: 82)
	buffer_save(buffer_compress(buf, 0, buffer_get_size(buf)), BASE_DIRECTORY + "/Save" + string(global.settings.saveFileIndex) + "/settings.PTM");
	buffer_delete(buf);
	
	Log("Saved Settings!");
}

/**
 * Loads the settings from a file. It can return these values:
 * 	0 - Nothing went wrong AKA Success!
 *  1 - Can't load it because we don't meet certain conditions.
 * 	2 - An error occured whilst trying to load the file.
 *  3 - (FATAL) An error occured while parsing the file.
 * @returns {real} 
 */
function LoadSettings() {
	Log("Going to load .settings..");
	if(global.settings.saveFileIndex == -1 || os_browser != browser_not_a_browser) {
		Log("Save file index is valid or we are a web browser, so we can't load settings!");
		return 1;
	}
	var file = buffer_load(BASE_DIRECTORY + "/Save" + string(global.settings.saveFileIndex) + "/settings.PTM");
	if(file == -1) {
		Log("Cannot load settings! (File doesn't exist, or something else.)");
		return 2;
	}
	file = buffer_decompress(file);
	if(file < 0) {
		Log("Failed to decompress the file!");
		return 2;
	}
	if(SETTINGS_VERSION == 0) {
		var parsed = buffer_read(file, buffer_string);
		try {
			if(parsed == -1) {
				LogError("This is fatal. We cannot read the save file.");
				throw(false);
			}
			parsed = json_parse(parsed);
			var names = variable_struct_get_names(parsed); //BUG - This was the actual settings, not the parsed settings, so settings that didn't exist back then crashed the game.
			for(var i = 0 ; i < array_length(names);i++) {
				variable_struct_set(global.settings, names[i], variable_struct_get(parsed, names[i])); //This will let the future settings still exist, while updating the previous version.
			}
		}
		catch(e) {
			LogError("(Fatal) We have failed to parse the save file.");
			return 3;
		}
	}
	else {
		var version = buffer_read(file, buffer_u8);
		if(version != SETTINGS_VERSION) {
			Log("Read version is outdated, returning...");
			return 2;
		}
		//Read gamepad stuff
		var settingNames = [
			//Struct of binding structs
			//"keyBinds",
			//The rest are fine
			"audio",
			"video",
			"gameplay",
			"player",
			"multiplayer"
		];
		//Override cuz I don't know how to remove gamepad name because of Gamemaker nonsense
		var valueNames = [
			"up",
			"down",
			"left",
			"right",
			"jump",
			"dash",
			"shoot",
		];
		var settings = undefined;
		var values = undefined;
		
		
		var keyType = buffer_u16;

		//Log("Writing keyBinds");
		for(var i = 0 ; i < 4;i++) {
			//Get current binding struct
			values = variable_struct_get(global.settings.keyBinds, "p" + string(i));
			//Log(string(values));
			for(var j = 0 ; j < array_length(valueNames);j++) {
				//Log("Applying key (" + valueNames[j] + ") for keyboard");
				
				//Write keys
				//var ogValue = variable_struct_get(values, valueNames[j]);
				variable_struct_set(values, valueNames[j], buffer_read(file, keyType) );
				//MarkDebugCode("Bruh");
				//if(variable_struct_get(values, valueNames[j]) != ogValue) {
				//	Log("Value for (" + valueNames[j] + ") is not equal to it's OG value! (keyboard)");
				//}
			}
			//Write gamepad bindings
			values = variable_struct_get(values, "gamepad");
			for(var j = 0 ; j < array_length(valueNames);j++) {
				//Log("Applying key (" + valueNames[j] + ") for gamepad");
				//Write keys
				//var ogValue = variable_struct_get(values, valueNames[j]);
				variable_struct_set(values, valueNames[j], buffer_read(file, keyType) );
				//MarkDebugCode("Bruh");
				//if(variable_struct_get(values, valueNames[j]) != ogValue) {
				//	Log("Value for (" + valueNames[j] + ") is not equal to it's OG value! (gamepad)");
				//}
			}
		}
		
		for(var i = 0 ; i < array_length(settingNames);i++) {
			settings = variable_struct_get(global.settings, settingNames[i]);
			valueNames = variable_struct_get_names(settings);
			//Log("Going to write section (" + settingNames[i] + ")");
			for(var j = 0 ; j < array_length(valueNames);j++) {
				//Log("Reading option (" + valueNames[j] + ")");
				//buffer_write(buf, buffer_u8, variable_struct_get(settings, valueNames[j]));
				//var ogValue = variable_struct_get(settings, valueNames[j]);
				variable_struct_set(settings, valueNames[j], buffer_read(file, buffer_u8));
				//var gotValue = variable_struct_get(settings, valueNames[j]);
				//if(gotValue != ogValue) {
				//	Log("	Value for (" + valueNames[j] + ") is not equal to it's OG value! (settings), excepted (" + string(ogValue) + "), got (" + string(gotValue) + ")");
				//}
			}
		}
	}
	buffer_delete(file);
	gc_collect();
	Log("Successfully loaded settings!");
	return true;
}
function CreateEffect(information) {
	if(global.settings.gameplay.fpsSave == FPSSaveMode.VisualRemover || global.settings.gameplay.fpsSave == FPSSaveMode.OnlyTheNeccessary) return;
	//if(!is_struct(information)) LogError("Invalid Effect!", true);
	if(information.sprite_index == sprite_effect_bang) PlaySound(choose(sfx_punch1, sfx_punch2, sfx_punch3, sfx_punch4, sfx_punch5), true);
	
	for(var i = 0 ; i < instance_number(o_P_Effect);i++) {
		//M_OPTI - Find a better way to check for same effects
		if(instance_find(o_P_Effect, i).sprite_index == information.sprite_index) return;
	}
	instance_create_depth(x,y,-1,o_P_Effect, information);
}
#macro IS_NETWORKING (instance_exists(Net_o_Client) || instance_exists(Net_o_Server))

