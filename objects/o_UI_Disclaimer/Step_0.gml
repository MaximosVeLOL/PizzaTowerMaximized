textDelay++;
if(textDelay == 5 && string_length(currentText) < string_length(text)) {
	currentText += string_copy(text, index, 1);
	index++;
	textDelay = 0;
}
if(keyboard_check_pressed(vk_anykey)) {
	if(string_length(currentText) == string_length(text)) {
		room_goto(Room_Level1_Basement);
	}
	else currentText = text;
}