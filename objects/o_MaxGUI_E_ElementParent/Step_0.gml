if(!o_MaxGUI_Handler.active || !visible) return;

//We still need to check even though we dont highlight
inBounds = (mouse_x >= x && mouse_x <= x + sprite_width && mouse_y >= y && mouse_y <= y + sprite_height);

if(doHighlight) {
	image_blend = (inBounds ? c_gray : MAXGUI_COLOR_HIGHLIGHT);
}