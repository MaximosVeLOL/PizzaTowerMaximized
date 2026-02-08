//if(!active) return;
with(o_MaxGUI_E_ElementParent) {
	if(alignedToGUI) {
		x = xstart + other.offset[0];
		y = ystart + other.offset[1];
	}
	other.isInteracting = (mouse_x >= bbox_left && mouse_x <= bbox_right && mouse_y >= bbox_top && mouse_y <= bbox_bottom);
}
/*
if(keyboard_check_pressed(vk_tab)) {
	
	Toggle();
	show_message(active);
	//offset[0] = get_integer("X Offset", "");
	//offset[1] = get_integer("Y Offset", "");
}
*/
//isInteracting = place_meeting(mouse_x, mouse_y, o_MaxGUI_E_ElementParent);