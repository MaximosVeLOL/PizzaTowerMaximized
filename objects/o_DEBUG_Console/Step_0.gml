if(keyboard_check_pressed(vk_control) && global.settings.gameplaySettings.debugEnabled) {
	active = !active;
	if(instance_exists(o_Camera)) o_Camera.hudVisible = !active;
	o_GameManager.mode = active ? "none" : "game";
	keyboard_string = "";
}
if(active) {
	if(keyboard_check_pressed(vk_enter)) {
		//if(os_browser != browser_not_a_browser) keyboard_string = string_lower(keyboard_string);
		var reqCommand = "";
		//Get the arguments
		var _temp = "";
		for(var i = 1; i <= string_length(keyboard_string);i++) {
			_temp += string_copy(keyboard_string, i, 1);
			if(string_count(" ", _temp) > 0 || i == string_length(keyboard_string)) {
				var actual = i == string_length(keyboard_string) ? _temp : string_copy(_temp, 0, string_length(_temp) - 1); //Because it includes a space
				
				if(reqCommand == "") reqCommand = actual;
				else {
					array_resize(currentArguments, array_length(currentArguments) + 1);
					currentArguments[array_length(currentArguments) - 1] = actual;
				}
				_temp = "";
			}
		}
		array_resize(prevCommands, array_length(prevCommands) + 1);
		prevCommands[array_length(prevCommands) - 1] = keyboard_string;
		prevCommandIndex = array_length(prevCommands) - 1;
		keyboard_string = "";
		//Find the command
		for(var i = 0 ; i < array_length(commands);i++) {
			if(commands[i].name == reqCommand) {
				try {
					commands[i].does();
				}
				catch(e) {
					var m = "Error!\n" + e.longMessage;
					Log(m);
					show_message(m);
				}
			}
		}
		currentArguments = [];
	}
	if(( keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_down) )&& array_length(prevCommands) > 0) {
		keyboard_string = prevCommands[prevCommandIndex];
		prevCommandIndex -= keyboard_check_pressed(vk_up) - keyboard_check_pressed(vk_down);
		prevCommandIndex = clamp(prevCommandIndex, 0, array_length(prevCommands) - 1);
	}
}