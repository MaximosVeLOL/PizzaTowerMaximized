switch(mode) {
	case "none":
	break;
	
	case "game":
		if((keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_enter)) && !instance_exists(o_UI_PauseMenu)) instance_create_depth(0,0,0,o_UI_PauseMenu);
	break;
	
	default:
		LogError("Undefined Gamemode! (" + mode + ")\n Defaulting to \"none\" ");
	break;
}