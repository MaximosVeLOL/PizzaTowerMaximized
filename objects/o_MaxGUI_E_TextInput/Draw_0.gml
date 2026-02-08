if(!o_GUIHandler.active || !visible) return;
draw_self();
draw_set_valign(fa_middle);
draw_text(x, y + (sprite_height / 2), text + (typeTimer < 50 ? "" : "|") );
if(mouse_check_button_pressed(mb_left) && mouse_x >= x & mouse_x <= x + sprite_width && mouse_y >= y && mouse_y <= y + sprite_height) {
	if(!isTyping) keyboard_string = "";
	isTyping = true;
	o_GUIHandler.isInteracting = true;
}

GUI_RESET;