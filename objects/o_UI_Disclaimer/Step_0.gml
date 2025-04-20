textDelay++;
if(textDelay == 4 && string_length(currentText) < string_length(text)) {
	currentText += string_copy(text, index, 1);
	index++;
	textDelay = 0;
}
if(keyboard_check_pressed(vk_anykey)) {
	if(string_length(currentText) == string_length(text)) {
		room_goto(ETBRoom_Tutorial1);
		o_MusicManager.playNewMusic(music_pizza);
	}
	else currentText = text;
}