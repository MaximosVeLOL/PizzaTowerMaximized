if(keyboard_check_pressed(vk_control)) {
	active = !active;
	keyboard_string = "";
}
if(active) {
	currentCommand = keyboard_string;
	
	if(keyboard_check_pressed(vk_enter)) {
		var reqCommand = "";
		var i = 0;
		//Get the arguments
		var _temp = "";
		for(i = 1; i <= string_length(currentCommand);i++) {
			_temp += string_copy(currentCommand, i, 1);
			if(string_count(" ", _temp) > 0 || i == string_length(currentCommand)) {
				var actual = i == string_length(currentCommand) ? _temp : string_copy(_temp, 0, string_length(_temp) - 1); //Because it includes a space
				
				if(reqCommand == "") reqCommand = actual;
				else {
					array_resize(currentArguments, array_length(currentArguments) + 1);
					currentArguments[array_length(currentArguments) - 1] = actual;
				}
				_temp = "";
			}
		}
		//Find the command
		for(i = 0 ; i < array_length(commands);i++) {
			if(commands[i].name == reqCommand) {
				try {
					commands[i].does();
				}
				catch(e) {
					show_message("Error!\n" + e.message);
				}
			}
		}
		keyboard_string = "";
		currentArguments = [];
	}
}