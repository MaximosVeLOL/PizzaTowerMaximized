if(!o_MaxGUI_Handler.active || !visible) return;
if(mouse_check_button_pressed(mb_left) && inBounds) {
	var returnVal = onClick();
	var isBool = (typeof(returnVal) == "bool");
	if(returnVal == undefined || isBool && returnVal) PlaySound(MaxGUI_click);
	if(isBool && !returnVal) PlaySound(MaxGUI_error, true);
}



draw_self();
draw_set_color(MAXGUI_COLOR_TEXT);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text(x + (sprite_width / 2),y + (sprite_height / 2),text);

GUI_RESET;