
if(!gotoLevel || !renderText) return;
var renderPos = [((x - camera_get_view_x(view_camera[0])) / camera_get_view_width(view_camera[0])) * display_get_gui_width(), ((bbox_top - camera_get_view_y(view_camera[0])) / camera_get_view_height(view_camera[0])) * display_get_gui_height()];
draw_set_font(global.misc.font);
draw_set_halign(fa_center);
draw_text(renderPos[0], renderPos[1], textToRender);
GUI_RESET;
	
	