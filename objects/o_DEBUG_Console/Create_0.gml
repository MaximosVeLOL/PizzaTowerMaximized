reusedFromBoxingBeast = true;
//Reused from another game called Boxing Beast
currentCommand = "";
active = false;
previousGameState = "";
currentArguments = [];

createCommand = function(_name, _does, _usage) constructor {
	name = _name;
	does = _does;
	usage = _usage;
}

commands = [
	
	new createCommand("instance_create", function() {
		//instance_create_depth(real(currentArguments[0]), real(currentArguments[1]), 0, asset_get_index(currentArguments[2]));
	}, "instance_create [x] [y] [name of object]"),
	
	new createCommand("crash", function() {
		throw(currentArguments[0]);
	}, "crash [message]"),
	
	new createCommand("option_set", function() {
		struct_set(settings, currentArguments[0], currentArguments[1]);
	}, "option_set [variable name] [new val]"),
	
	new createCommand("reset", game_restart, "reset"),
	
	new createCommand("player_set_state", function() {
		obj_player.setState(currentArguments[0]);
	}, "player_set_state [new state]"),
	
	new createCommand("room_goto", function() {
		//RoomGoto(asset_get_index(currentArguments[0]), [currentArguments[1], currentArguments[2]]);
	}, "room_goto [room] [x] [y]"),
	
	new createCommand("room_check", function() {
		var check = false;
		var roomI = 0;
		var timer = 0;
		while(roomI != room_last) {
			if(!check) {
				room_goto(roomI);
				check = true;
			}
			else {
				timer++;
				if(timer >= 60) {
					check = false;
					timer = 0;
				}
			}
			
		}
	}, "room_check"),
	
	new createCommand("instances_list", function() {
		var str = "";
		for(var i = 0 ; i < instance_count ;i++ ) {
			str += object_get_name(instance_find(all, i).object_index) + ", ";
		}
		show_message(str);
	}, "instances_list")

];

settings = {
	renderDebugText : true,
	renderPlayerMask : true,
	renderCollision : true,
	
}