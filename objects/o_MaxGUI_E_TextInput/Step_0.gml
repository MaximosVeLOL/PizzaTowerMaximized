event_inherited();
if(isTyping) {
	typeTimer++;
	if(typeTimer > 100) typeTimer = 0;
	image_blend = c_gray;
	text = keyboard_string;
	if(keyboard_check_pressed(vk_enter)) FinishTyping();
}