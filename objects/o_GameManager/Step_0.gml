switch(mode) {
	case "none":
	break;
	
	case "game":
		if((keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_enter)) && !instance_exists(o_UI_PauseMenu)) instance_create_depth(0,0,0,o_UI_PauseMenu);
	break;
	
	case "editor":
	break;
	
	default:
		LogError("Undefined Gamemode! (" + mode + ")\n Defaulting to \"none\" ");
	break;
}
if(keyboard_check_pressed(vk_f12)) {
	var variable = 0;
	var dir;
	var val = 2;
	switch(val) { //Different screenshot modes, just incase
		case 0: //Save in room
			
			while(file_exists("MaximizedGM2/Screenshots/Rooms/" + room_get_name(room) + "/screenshot" + string(variable) + ".png" )) {
				variable++;
			}
			dir = "MaximizedGM2/Screenshots/Rooms/" + room_get_name(room) + "/screenshot" + string(variable);
		break;
		
		case 1: //Save in session
			while(file_exists("MaximizedGM2/Screenshots/Sessions/session" + string(sessions.total) + "/screenshot" + string(variable) + ".png" )) {
				variable++;
			}
			dir = "MaximizedGM2/Screenshots/Sessions/session" + string(sessions.total) + "/screenshot" + string(variable)
		break;
		
		case 2: //Save in save file
			while(file_exists("MaximizedGM2/Save" + string(global.settings.saveFileIndex) + "/Screenshots/screenshot" + string(variable) + ".png" )) {
				variable++;
			}
			dir = "MaximizedGM2/Save" + string(global.settings.saveFileIndex) + "/Screenshots/screenshot" + string(variable);
		break;
		
		
	}
	screen_save(dir + ".png");
}