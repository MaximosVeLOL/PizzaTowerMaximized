draw_self();
if(instance_exists(o_DEBUG_Console) && o_DEBUG_Console.settings.renderPlayerMask) {
	draw_set_color((plrGoFast ? c_green : c_red));
	draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
	GUI_RESET;
}