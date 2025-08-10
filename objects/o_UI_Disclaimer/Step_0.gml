textDelay++;
if(textDelay == 4 && string_length(currentText) < string_length(text) ) {
	currentText += string_copy(text, string_length(currentText) + 1, 1);
	textDelay = 0;
}
if( (keyboard_check_pressed(vk_anykey) || GetInput("jump", 1) ) && keyboard_key != keys[keyI]) {
	if(currentText == text) {
		//o_GameManager.startLevel(ETBRoom_Tutorial1, [828, 402], music_pizza);
		room_goto(Room_MainMenu);
		//draw_enable_drawevent(false);
		GUI_RESET;
	}
	currentText = text;
}
if(keyboard_check_pressed(keys[keyI])) {
	keyI++;
	PlaySound(sound_menuchange, false, false, true);
	if(keyI == array_length(keys)) {
		PlaySound(sound_menuselect);
		global.settings.gameplaySettings.goonerMode = true;
		//LogError("");
		keyI = 0;
	}
}