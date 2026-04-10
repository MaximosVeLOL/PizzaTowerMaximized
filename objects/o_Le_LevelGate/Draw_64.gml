
if(!gotoLevel || !renderText) return;
var renderPos = new Vector(((x - camera_get_view_x(view_camera[0])) / camera_get_view_width(view_camera[0])) * display_get_gui_width(), ((bbox_top - camera_get_view_y(view_camera[0])) / camera_get_view_height(view_camera[0])) * display_get_gui_height());
draw_set_font(global.misc.font);
draw_set_halign(fa_center);
draw_text(renderPos.x, renderPos.y, textToRender );
var c = c_white;
if(gotData) {
	for(var i = 0 ; i < 5; i++) {
		if(pizzakins[i])
			c = c_white;
		else 
			c = c_black;
	
		draw_sprite_ext(pizzakinSprite[i], 0, (renderPos.x - 80) + (i * 42), renderPos.y + 96, 1, 1, 0, c, 1);
	}
}
GUI_RESET;
	
	