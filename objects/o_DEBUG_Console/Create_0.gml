reusedFromBoxingBeast = true;
//Reused from another game called Boxing Beast
active = false;
currentArguments = [];
prevCommands = [];
prevCommandIndex = 0;
logs = [];
createCommand = function(_name, _does, _usage) constructor {
	name = _name;
	does = _does;
	usage = _usage;
}

commands = [
	
	new createCommand("instance_create", function() {
		instance_create_depth(real(currentArguments[0]), real(currentArguments[1]), 0, asset_get_index(currentArguments[2]));
	}, "instance_create [x] [y] [name of object]"),
	
	new createCommand("crash", function() {
		throw(currentArguments[0]);
	}, "crash [message]"),
	
	new createCommand("option_debug_set", function() {
		struct_set(settings, currentArguments[0], currentArguments[1]);
	}, "option_debug_set [variable name] [new val]"),
	
	new createCommand("option_set [option type struct] [option name] [new value]", function() {
		variable_struct_set(struct_get(global.settings, currentArguments[0]), currentArguments[1], currentArguments[2]);
	}, "option_set [option name] [new value]"),
	
	new createCommand("reset", game_restart, "reset"),
	
	new createCommand("player_set_state", function() {
		o_PlayerParent.setState(currentArguments[0]);
	}, "player_set_state [new state]"),
	
	new createCommand("room_goto", function() {
		if(asset_get_index(currentArguments[0]) != -1) {
			if(instance_exists(o_GameManager) && instance_exists(o_PlayerParent)) o_GameManager.gotoRoom(asset_get_index(string(currentArguments[0])), [currentArguments[1], currentArguments[2]], -1, false);
			else room_goto(asset_get_index(string(currentArguments[0])));
		}
	}, "room_goto [room] [x] [y]"),
	
	new createCommand("instances_list", function() {
		var str = "";
		for(var i = 0 ; i < instance_count ;i++ ) {
			str += object_get_name(instance_find(all, i).object_index) + ", ";
		}
		show_message(str);
	}, "instances_list"),
	
	new createCommand("hurt", function() {
		o_PlayerParent.hurt();
	}, "hurt"),
	
	new createCommand("pizza_time", function() {
		if(array_length(currentArguments) == 0) currentArguments[0] = 340;
		instance_create_depth(0,0,0,o_PizzaTimeManager);
		o_GameManager.level.time = currentArguments[0];
	}, "pizza_time [time]"),
	
	new createCommand("new_song", function() {
		if(array_length(currentArguments) <= 1) currentArguments = [currentArguments[0], -1,-1];
		o_MusicManager.playNewSong(asset_get_index(currentArguments[0]), [currentArguments[1], currentArguments[2]]);
	}, "new_song [newsong] [loop point = -1]"),
	
	new createCommand("get_vari", function() {
		var inst = instance_find(asset_get_index(currentArguments[0]), 0);
		if(inst == noone) throw("Failed to find the targeted instance!");
		var array = variable_instance_get_names(inst);
		var total = "";
		for(var i = 0 ; i < array_length(array);i++) {
			total += array[i] + ": " + string(variable_instance_get(inst, array[i])) + "\n";
		}
		show_message(total);
	}, "get_vari [object]"),
	
	new createCommand("get_vari_ext", function() {
		var inst = instance_find(asset_get_index(currentArguments[0]), 0);
		if(inst == noone) throw("Failed to find the targeted instance!");
		if(!variable_instance_exists(inst, currentArguments[1])) throw("Failed to find the targeted variable!");
		show_message(currentArguments[1] + ": " + string(variable_instance_get(inst, currentArguments[1])));
	}, "get_vari_ext [object] [req variable name]"),
	
	new createCommand("get_log", function() {
		var out = "";
		for(var i = 0 ; i < array_length(logs);i++) {
			out += logs[i] + "\n";
		}
		show_message(out);
	}, "get_log"),
	
	new createCommand("set_speed", function() {
		game_set_speed(currentArguments[0], gamespeed_fps);
	}, "set_speed"),
	
	new createCommand("log", function() {
		Log(currentArguments[0]);
	}, "log [message]"),
	
	new createCommand("set_score", function() {
		score = currentArguments[0];
	}, "set_score [new score]"),
	
	new createCommand("save", SaveSettings, "save"),
	new createCommand("load", LoadSettings, "load"),
	
	new createCommand("shake_cam", function(){
		ShakeCamera(currentArguments[0], currentArguments[1]);
	}, "shake_cam [mag] [acc]")

];
executeCommand = function(commandString) {
		var reqCommand = "";
		//Get the arguments
		var _temp = "";
		for(var i = 1; i <= string_length(commandString);i++) {
			_temp += string_copy(commandString, i, 1);
			if(string_count(" ", _temp) > 0 || i == string_length(commandString)) {
				var actual = i == string_length(commandString) ? _temp : string_copy(_temp, 0, string_length(_temp) - 1); //Because it includes a space
				
				if(reqCommand == "") reqCommand = actual;
				else {
					array_resize(currentArguments, array_length(currentArguments) + 1);
					currentArguments[array_length(currentArguments) - 1] = actual;
				}
				_temp = "";
			}
		}
		array_resize(prevCommands, array_length(prevCommands) + 1);
		prevCommands[array_length(prevCommands) - 1] = commandString;
		prevCommandIndex = array_length(prevCommands) - 1;
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
settings = {
	renderDebugText : true,
	renderPlayerMask : false,
	renderCollision : true,
	debugKeys : true,
}