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
	while(directory_exists("MaximizedGM2/Screenshots/session" + string(screenshotSession) )) {
		screenshotSession++;
	}
	var dir = "MaximizedGM2/Screenshots/session" + string(screenshotSession);
	directory_create(dir);
	var shot = 1;
	while(file_exists(dir + "/shot" + string(shot) + ".png")) {
		shot++;
	}
	screen_save(dir + "/shot" + string(shot) + ".png");
}