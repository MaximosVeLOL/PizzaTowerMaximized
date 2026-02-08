if(!o_GUIHandler.active || !visible) return;

//We still need to check even though we dont highlight
inBounds = (mouse_x >= bbox_left && mouse_x <= bbox_right && mouse_y >= bbox_top && mouse_y <= bbox_bottom);

if(doHighlight) {
	if(mouse_x >= bbox_left && mouse_x <= bbox_right && mouse_y >= bbox_top && mouse_y <= bbox_bottom) {
		image_blend = c_gray;
	}
	else {
		image_blend = COLOR_HIGHLIGHT;
	}
}