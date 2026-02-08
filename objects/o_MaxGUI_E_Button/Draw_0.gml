if(!o_GUIHandler.active || !visible) return;
if(mouse_check_button_pressed(mb_left) && inBounds) {
	onClick();
}



draw_self();
draw_set_color(COLOR_TEXT);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text(x + (sprite_width / 2),y + (sprite_height / 2),text);

GUI_RESET;