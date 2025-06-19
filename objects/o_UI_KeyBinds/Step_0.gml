if(currentScreen == 0) {
	event_inherited();
}
else {
	if(keyboard_key != lastKeyInput && keyboard_key != vk_nokey) {
		variable_struct_set(variable_struct_get(global.settings.keyBinds, "p" + string(targetProfile)), keys[currentOption], keyboard_key);
		setScreen(0);
	}
	lastKeyInput = keyboard_key;
}