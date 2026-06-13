
if( (keyboard_check_pressed(vk_anykey) || GamepadDetectAny() ) && keyboard_key != keys[keyI]) {
	if(currentText == text) {
		//o_GameManager.startLevel(ETBRoom_Tutorial1, [828, 402], music_pizza);
		room_goto(Room_MainMenu);
		//draw_enable_drawevent(false);
		GUI_RESET;
		return;
	}
	currentText = text;
}
if(keyboard_check_pressed(keys[keyI])) {
	keyI++;
	PlaySound(sound_menuchange, false, false, true);
	if(keyI == array_length(keys)) {
		PlaySound(sound_menuselect);
		global.settings.gameplay.goonerMode = true;
		//LogError("");
		keyI = 0;
	}
}
if(style != 0) return;
textDelay++;
if(textDelay == 4 && string_length(currentText) < string_length(text) ) {
	currentText = string_copy(text, 0, string_length(currentText) + 1);
	textDelay = 0;
	if(string_char_at(text, string_length(currentText)) != "\n") PlaySound(choose(sound_type1, sound_type2, sound_type3), false, false, true);
}