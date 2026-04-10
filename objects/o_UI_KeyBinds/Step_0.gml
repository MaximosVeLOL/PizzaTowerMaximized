if(currentScreen == 0) {
	targetProfile += (keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left));
	if(targetProfile < 0) targetProfile = MAX_PLAYERS - 1;
	else if(targetProfile >= MAX_PLAYERS) targetProfile = 0;
	event_inherited();
}
else {
	if(keyboard_key != lastKeyInput && keyboard_key != vk_nokey) {
		variable_struct_set(variable_struct_get(global.settings.keyBinds, "p" + string(targetProfile)), keys[currentOption], keyboard_key);
		setScreen(0);
	}
	//if(gamepad_button_check(targetProfile, gp_))
	lastKeyInput = keyboard_key;
}