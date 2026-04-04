if(!o_MaxGUI_Handler.active || !visible) return;
draw_self();
draw_set_valign(fa_middle);
draw_text(x, y + (sprite_height / 2), text + (typeTimer < 50 ? "" : "|") );
if(mouse_check_button_pressed(mb_left) && inBounds) {
	if(!isTyping) keyboard_string = "";
	isTyping = true;
	o_MaxGUI_Handler.isTyping = true;
}

GUI_RESET;