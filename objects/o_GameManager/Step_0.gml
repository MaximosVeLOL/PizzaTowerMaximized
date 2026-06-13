
switch(mode) {
	case GameState.None:
	break;
	
	case GameState.Game:
		if(keyboard_check_pressed(ord("C"))) {
			if(instance_exists(o_Player)) {
				instance_deactivate_object(o_Player);
			}
			else instance_activate_object(o_Player);
		}
		if((keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_enter)) && !instance_exists(o_UI_Pause)) instance_create_depth(0,0,0,o_UI_Pause);
		if(level.update) {
			level.timer += TIME_BASE;
		}
	break;
	
	//case "editor":
	//break;
	
	default:
		LogError("Undefined Gamemode! (" + string(mode) + ")\n Defaulting to \"none\" ");
		mode = GameState.None;
	break;
}
if(keyboard_check_pressed(vk_f12)) {
	var variable = 0;
	var dir;
	var val = 2;
	switch(val) { //Different screenshot modes, just incase
		case 0: //Save in room
			
			while(file_exists(BASE_DIRECTORY + "/Screenshots/Rooms/" + room_get_name(room) + "/screenshot" + string(variable) + ".png" )) {
				variable++;
			}
			dir = BASE_DIRECTORY + "/Screenshots/Rooms/" + room_get_name(room) + "/screenshot" + string(variable);
		break;
		
		case 1: //Save in session
			while(file_exists(BASE_DIRECTORY + "/Screenshots/Sessions/session" + string(sessions.total) + "/screenshot" + string(variable) + ".png" )) {
				variable++;
			}
			dir = BASE_DIRECTORY + "/Screenshots/Sessions/session" + string(sessions.total) + "/screenshot" + string(variable)
		break;
		
		case 2: //Save in save file
			while(file_exists(BASE_DIRECTORY + "/Save" + string(global.settings.saveFileIndex) + "/Screenshots/screenshot" + string(variable) + ".png" )) {
				variable++;
			}
			dir = BASE_DIRECTORY + "/Save" + string(global.settings.saveFileIndex) + "/Screenshots/screenshot" + string(variable);
		break;
		
		
	}
	screen_save(dir + ".png");
}