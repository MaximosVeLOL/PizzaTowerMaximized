#macro SETTINGS_VERSION 0x01
/* Versions:
 * 0 - JSON version (very bulky and unsafe for future builds,
 * As values can be removed and then makes everything worse)
 * 1 - Custom version (small file size with better optimizations.
 * Instead of using JSON stringify, we can only export the values,
 * Which saves alot of space. And plus, the JSONs were never readable.
*/
function ApplySettings() {
	Log("Going to apply settings...");
	if(IS_WEB_BUILD) return;
	if(global.settings.audio.muteAll || global.settings.audio.musicVolume == 0) {
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
		if(instance_exists(o_Camera)) 
			o_Camera.setupRoom();
		//for (var i = 0 ; i < instance_number(o_Player);i++)
		//	o_MultiplayerHandler.DefinePlayer(instance_find(o_Player, i), i);
	}
	else if(instance_exists(o_MultiplayerHandler))
		instance_destroy(o_MultiplayerHandler);
	if(global.settings.gameplay.debugEnabled) {
		if(!instance_exists(o_DEBUG_Console)) instance_create_depth(0,0,0,o_DEBUG_Console);
	}
	else 
		instance_destroy(o_DEBUG_Console);
	if(global.settings.video.mobileMode) {
		if(!instance_exists(o_MobileSystem))
			instance_create_layer(0, 0, "Instances", o_MobileSystem);
	}
	else {
		with(o_MobileSystem)
			instance_destroy();
	}
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
	Log("Going to save...");
	if(global.settings.saveFileIndex == -1 || IS_WEB_BUILD) return;
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
	Log("Going to load settings...");
	if(global.settings.saveFileIndex == -1 || IS_WEB_BUILD) {
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
	var version = buffer_read(file, buffer_u8);
	/*
	if(version != SETTINGS_VERSION) {
		//return 2;
	}
	*/
	if(version != SETTINGS_VERSION) {
		Log("Read version is outdated (" + string(version) + "), converting...");
		var parsed = buffer_read(file, buffer_text);
		try {
			if(parsed == -1) {
				LogError("This is fatal. We cannot read the save file.");
				throw(false);
			}
			
			parsed = json_parse(parsed);
			if(parsed == undefined)
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