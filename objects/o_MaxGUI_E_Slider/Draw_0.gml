if(!o_GUIHandler.active || !visible) return;
if(mouse_check_button(mb_left) && mouse_x > bbox_left && mouse_x < bbox_right) {
	currentValue = ((mouse_x - x) / sprite_width) * maximumValue;
}
draw_self();
var percentage = currentValue / maximumValue;
draw_roundrect_color(x, y, x + sprite_width * percentage, y + sprite_height, c_green, c_green, false);